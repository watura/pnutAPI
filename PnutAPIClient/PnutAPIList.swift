import UIKit
import OAuthSwift
import APIKit
import PnutAPI

enum PnutAPIList: String {
    case authorize
    case lookupUser
    case lookupUsers
    case postLifecyclePost
    case deleteToken
    case getToken

    static var count: Int { return 5 }

    static var list: [PnutAPIList] {
        return [.authorize, .lookupUser, .lookupUsers, .postLifecyclePost, .deleteToken, .getToken]
    }

    func action(viewController: UIViewController) {
        switch self {
        case .authorize:
            let manager = APITokenManager()
            _ = manager.authorize(viewController: viewController)
        case .lookupUser:
            LookupUserRequest(userId: "1").request()
        case .lookupUsers:
            LookupUsersRequest(ids: ["1", "136"]).request()
        case .postLifecyclePost:
            let body = PostBody(text: "Test Post \(Date())")
            PostRequest(postBody: body).request()
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
