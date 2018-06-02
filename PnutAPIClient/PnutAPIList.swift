import UIKit
import OAuthSwift
import APIKit
import PnutAPI

enum PnutAPIList: String {
    case authorize
    case getUser
    case getUsers
    case deleteToken
    case getToken

    static var count: Int { return 5 }

    static var list: [PnutAPIList] {
        return [.authorize, .getUser, .getUsers, .deleteToken, .getToken]
    }

    func action(viewController: UIViewController) {
        switch self {
        case .authorize:
            let manager = APITokenManager()
            _ = manager.authorize(viewController: viewController)
        case .getUser:
            GetUserRequest(userId: "1").request()
        case .getUsers:
            GetUsersRequest(ids: ["1", "136"]).request()
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
