import Foundation
import Moya

// 키체인이나 UserDefaults에 저장해둔 토큰 헤더에 넣기
// 라이브러리 : Moya, KeychainSwift 사용
final class BearerTokenPlugin: PluginType {
    private var accessToken: String? {
        return LoginViewController.keychain.get("serverAccessToken")
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        // 만약 accessToken이 있다면 Authorization 헤더에 추가합니다.
        if let token = accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
}
