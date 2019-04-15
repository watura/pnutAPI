import UIKit
import OAuthSwift
import APIKit
import PnutAPI
import PostViewController

enum PnutAPIList: String, CaseIterable {
    case authorize

    case lookupUser
    case lookupUsers

    case usersMePut

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

    static var count: Int { return PnutAPIList.allCases.count }

    func action(viewController: UIViewController) {
        switch self {
        case .authorize:
            let manager = APITokenManager.shared
            _ = ((try? manager.authorize(viewController: viewController)) as OAuthSwiftRequestHandle??)
        case .usersMePut:
            let userObj = Users.Me.UserObject(timezone: "Asia/Tokyo", locale: "ja_JP", name: "wtr", text: "Update From PnutAPIList")
            Users.Me.Put(object: userObj).request()
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
        let body = PostBody(text: text)
        PostRequest(postBody: body).request()
    }

    func validate(text: String) -> Bool {
        return true
    }
}
