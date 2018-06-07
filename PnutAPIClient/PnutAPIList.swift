import UIKit
import OAuthSwift
import APIKit
import PnutAPI
import PostViewController

enum PnutAPIList: String {
    case authorize

    case lookupUser
    case lookupUsers

    case postLifecyclePost
    case postLifecycleRevise
    case postLifecycleDelete

    case postStreams
    case unifiedPostStreams
    case mentionsPostStreams
    case postsPostStreams
    case globalPostStreams
    case tagsPostStreams

    case deleteToken
    case getToken

    static var count: Int { return PnutAPIList.list.count }

    static var list: [PnutAPIList] {
        return [.authorize, .lookupUser, .lookupUsers, .postLifecyclePost, .postLifecycleRevise, .postLifecycleDelete, .postStreams, .unifiedPostStreams, .mentionsPostStreams, .postsPostStreams, .globalPostStreams, .tagsPostStreams, .deleteToken, .getToken]
    }

    func action(viewController: UIViewController) {
        switch self {
        case .authorize:
            let manager = APITokenManager.shared
            _ = try? manager.authorize(viewController: viewController)
        case .lookupUser:
            LookupUserRequest(userId: "1").request()
        case .lookupUsers:
            LookupUsersRequest(ids: ["1", "136"]).request()
        case .postLifecyclePost:
            guard let pvc = PostViewController.initView() else { fatalError() }
            pvc.postAction = self
            viewController.navigationController?.pushViewController(pvc, animated: true)
        case .postLifecycleRevise:
            let body = PostBody(text: "Revised Test Post  \(Date())")
            RevisePostRequest(id: "378143", postBody: body).request()
        case .postStreams:
            PostStreamsRequest().request()
        case .unifiedPostStreams:
            UnifiedPostStreamsRequest().request()
        case .mentionsPostStreams:
            MentionsPostStreamsRequest().request()
        case .postsPostStreams:
            UserPostStreamsRequest().request()
        case .globalPostStreams:
            GlobalPostStreamsRequest().request()
        case .tagsPostStreams:
            TagsPostStreamsRequest(tag: "MondayNightDanceParty").request()
        case .postLifecycleDelete:
            DeletePostRequest(id: "378143").request()
        case .deleteToken:
            DeleteTokenRequest().request(success: { success in
                let manager = APITokenManager.shared
                manager.removeToken()
                viewController.title = "has Token? \(manager.hasToken)"
            })
        case .getToken:
            GetTokenRequest().request()
        }
    }
}

extension PnutAPIList: PostAction {
    func cancel() {
    }

    func compelete(text: String) {
        let body = PostBody(text: "Revised Test Post  \(Date())")
        PostRequest(postBody: body).request()
    }

    func validate(text: String) -> Bool {
        return true
    }
}
