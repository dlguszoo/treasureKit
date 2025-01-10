// Copyright © 2024 DRINKIG. All rights reserved

import Foundation

// 최상위 응답 모델
public struct ApiResponse<T: Decodable>: Decodable {
    public let isSuccess: Bool
    public let code: String
    public let message: String
    public let result: T?
}

public struct EmptyResponse: Decodable {}
