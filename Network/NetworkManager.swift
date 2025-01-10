import Foundtion

protocol NetworkManager {
    associatedtype Endpoint: TargetType

    var provider: MoyaProvider<Endpoint> { get }
    
    // ✅ 일반 데이터 요청 (T, 필수값)
    func request<T: Decodable>(
        target: Endpoint,
        decodingType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
    
    // ✅ 일반 데이터 요청 (T?, 옵셔널)
    func requestOptional<T: Decodable>(
        target: Endpoint,
        decodingType: T.Type,
        completion: @escaping (Result<T?, NetworkError>) -> Void
    )
    
    // ✅ HTTP 상태 코드만 확인
    func requestStatusCode(
        target: Endpoint,
        completion: @escaping (Result<Int, NetworkError>) -> Void
    )
}


extension NetworkManager {
    
    // ✅ 1. 필수 데이터 요청
    func request<T: Decodable>(
        target: Endpoint,
        decodingType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                let result: Result<T, NetworkError> = self.handleResponse(response, decodingType: decodingType)
                completion(result)
            case .failure(let error):
                completion(.failure(self.handleNetworkError(error)))
            }
        }
    }
    
    // ✅ 2. 옵셔널 데이터 요청
    func requestOptional<T: Decodable>(
        target: Endpoint,
        decodingType: T.Type,
        completion: @escaping (Result<T?, NetworkError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                let result: Result<T?, NetworkError> = self.handleResponseOptional(response, decodingType: decodingType)
                completion(result)
            case .failure(let error):
                completion(.failure(self.handleNetworkError(error)))
            }
        }
    }
    
    // ✅ 3. 상태 코드만 확인
    func requestStatusCode(
        target: Endpoint,
        completion: @escaping (Result<Int, NetworkError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                guard (200...299).contains(response.statusCode) else {
                    let errorMessage = "상태 코드 오류: \(response.statusCode)"
                    completion(.failure(.serverError(statusCode: response.statusCode, message: errorMessage)))
                    return
                }
                completion(.success(response.statusCode))
            case .failure(let error):
                completion(.failure(self.handleNetworkError(error)))
            }
        }
    }
    
    // ✅ 4. 유효기간 파싱 + 데이터 파싱
    func requestWithTime<T: Decodable>(
        target: Endpoint,
        decodingType: T.Type,
        completion: @escaping (Result<(T, TimeInterval?), NetworkError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                let result: Result<(T, TimeInterval?), NetworkError> = self.handleResponseTimeInterval(response, decodingType: decodingType)
                completion(result)
            case .failure(let error):
                completion(.failure(self.handleNetworkError(error)))
            }
        }
    }
    
    // MARK: - 응답 처리 함수
    
    /// 필수 값 응답 처리
    private func handleResponse<T: Decodable>(
        _ response: Response,
        decodingType: T.Type
    ) -> Result<T, NetworkError> {
        do {
            try validateStatusCode(response)
            let apiResponse = try decodeApiResponse(response, decodingType: decodingType)
            guard let result = apiResponse.result else {
                return .failure(.serverError(statusCode: response.statusCode, message: "결과 데이터가 없습니다."))
            }
            return .success(result)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.decodingError)
        }
    }
    
    /// 옵셔널 값 응답 처리
    private func handleResponseOptional<T: Decodable>(
        _ response: Response,
        decodingType: T.Type
    ) -> Result<T?, NetworkError> {
        do {
            try validateStatusCode(response)
            let apiResponse = try decodeApiResponse(response, decodingType: decodingType)
            return .success(apiResponse.result)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.decodingError)
        }
    }
    
    /// 유효 기간 + 데이터 응답 처리
    private func handleResponseTimeInterval<T: Decodable>(
        _ response: Response,
        decodingType: T.Type
    ) -> Result<(T, TimeInterval?), NetworkError> {
        do {
            try validateStatusCode(response)
            let apiResponse = try decodeApiResponse(response, decodingType: decodingType)
            guard let result = apiResponse.result else {
                return .failure(.serverError(statusCode: response.statusCode, message: "결과 데이터가 없습니다."))
            }
            let cacheDuration = extractCacheTimeInterval(from: response)
            return .success((result, cacheDuration))
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.decodingError)
        }
    }
    
    // MARK: - 상태 코드 및 디코딩 처리
    
    /// 상태 코드 검증
    private func validateStatusCode(_ response: Response) throws {
        guard (200...299).contains(response.statusCode) else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: response.data)
            let message = errorResponse?.message ?? "상태 코드 오류 발생: \(response.statusCode)"
            throw NetworkError.serverError(statusCode: response.statusCode, message: message)
        }
    }
    
    /// Cache-Control 유효 시간 추출
    private func extractCacheTimeInterval(from response: Response) -> TimeInterval? {
        guard let httpResponse = response.response,
              let cacheControl = httpResponse.allHeaderFields["Cache-Control"] as? String else {
            return nil
        }

        let components = cacheControl.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        for component in components {
            if component.starts(with: "max-age") {
                if let maxAgeString = component.split(separator: "=").last,
                   let maxAge = TimeInterval(maxAgeString) {
                    return maxAge
                }
            }
        }
        return nil
    }
    
    // MARK: - 네트워크 오류 처리 함수
    
    /// 네트워크 오류 처리
    private func handleNetworkError(_ error: Error) -> NetworkError {
        let nsError = error as NSError
        switch nsError.code {
        case NSURLErrorNotConnectedToInternet:
            return .networkError(message: "인터넷 연결이 끊겼습니다.")
        case NSURLErrorTimedOut:
            return .networkError(message: "요청 시간이 초과되었습니다.")
        default:
            return .networkError(message: "네트워크 오류가 발생했습니다.")
        }
    }
}
