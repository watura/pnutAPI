import Foundation
import OAuthSwift

struct APITokenManager {
    private let oauthSwift: OAuth2Swift
    private let TokenKey = "OAuthToken"

    init() {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist" ),
            let plist = NSDictionary(contentsOfFile: filePath) else {
                fatalError("Could not load plist")
        }

        guard let clientId = plist["PnutClientID"] as? String,
            let clientSecret = plist["PnutClientSecret"] as? String else {
                fatalError("Could not read secrets")
        }

        oauthSwift = OAuth2Swift(
            consumerKey: clientId,
            consumerSecret: clientSecret,
            authorizeUrl: "https://pnut.io/oauth/authenticate",
            responseType: "token"
        )
    }

    func authorize(viewController: UIViewController) -> OAuthSwiftRequestHandle? {
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthSwift)
        guard let callback = URL(string: "pnut-callback://pnut-callback/pnut") else { fatalError() }

        return oauthSwift.authorize(
            withCallbackURL: callback,
            scope: "basic+stream+write_post+follow+update_profile+presence+messages+files+polls", state: "",
            success: { [TokenKey] credential, response, parameters in
                let ud = UserDefaults.standard
                ud.set(credential.oauthToken, forKey: TokenKey)
                ud.synchronize()
        }, failure: { error in
            print(error.localizedDescription)
        }
        )
    }

    func removeToken() {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: TokenKey)
        ud.synchronize()
        print("Token removed")
    }
}

extension APITokenManager {
    var hasToken: Bool {
        return token != nil
    }

    var credential: OAuthSwiftCredential {
        let cred = oauthSwift.client.credential
        cred.oauthToken = token ?? ""
        return cred
    }
}

extension APITokenManager {
    private var token: String? {
        let ud = UserDefaults.standard
        return ud.string(forKey: TokenKey)
    }
}
