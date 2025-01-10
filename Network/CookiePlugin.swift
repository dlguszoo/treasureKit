import Foundation
import Moya

// 저장된 쿠키를 헤더에 추가하기
class CookiePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        // 저장된 쿠키를 가져와서 헤더에 추가
        if let cookies = HTTPCookieStorage.shared.cookies {
            let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)
            for (key, value) in cookieHeader {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
