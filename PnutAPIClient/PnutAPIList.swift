import UIKit
import OAuthSwift
import APIKit
import PnutAPI

enum PnutAPIList: String {
    case authorize
    case lookupUser
    case lookupUsers
    case postLifecyclePost
    case postLifecycleRevise
    case postLifecycleDelete

    case deleteToken
    case getToken

    static var count: Int { return 8 }

    static var list: [PnutAPIList] {
        return [.authorize, .lookupUser, .lookupUsers, .postLifecyclePost, .postLifecycleRevise, .postLifecycleDelete, .deleteToken, .getToken]
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
        case .postLifecycleRevise:
            let body = PostBody(text: "Revised Test Post  \(Date())")
            RevisePostRequest(id: "378143", postBody: body).request()
        case .postLifecycleDelete:
            DeletePostRequest(id: "378143").request()
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
