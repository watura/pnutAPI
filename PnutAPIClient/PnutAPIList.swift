import UIKit
import OAuthSwift
import APIKit
import PnutAPI

enum PnutAPIList: String {
    case authorize
    case deleteToken
    case getToken

    static var count: Int { return 3 }

    static var list: [PnutAPIList] {
        return [.authorize, .deleteToken, .getToken]
    }

    func action(viewController: UIViewController) {
        switch self {
        case .authorize:
            let manager = APITokenManager()
            _ = manager.authorize(viewController: viewController)
        case .deleteToken:
            DeleteTokenRequest().request(success: { success in
                let manager = APITokenManager()
                manager.removeToken()
                viewController.title = "has Token? \(manager.hasToken)"
            })
        case .getToken:
            GetTokenRequest().request()
        }
    }
}
