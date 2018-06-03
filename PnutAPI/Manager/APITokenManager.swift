import Foundation
import OAuthSwift

public class APITokenManager {
    public static let shared = APITokenManager()
    private var oauthSwift: OAuth2Swift?
    private let TokenKey = "OAuthToken"
    private var callbackUrl: String?

    private init() {}

    public func setCredentials(clientId: String, clientSecret: String, callbackUrl: String) {
        oauthSwift = OAuth2Swift(
            consumerKey: clientId,
            consumerSecret: clientSecret,
            authorizeUrl: "https://pnut.io/oauth/authenticate",
            responseType: "token"
        )
        self.callbackUrl = callbackUrl
    }

    public func authorize(viewController: UIViewController) throws -> OAuthSwiftRequestHandle? {
        guard let oauthSwift = oauthSwift else {
            throw APITokenManagerError.noOAuthSwiftInstance
        }
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthSwift)
        guard let callbackUrl = self.callbackUrl,
            let callback = URL(string: callbackUrl) else { fatalError() }

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

    public func removeToken() {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: TokenKey)
        ud.synchronize()
        print("Token removed")
    }
}

public extension APITokenManager {
    public var hasToken: Bool {
        return token != nil
    }

    public func credential() throws -> OAuthSwiftCredential {
        guard let cred = oauthSwift?.client.credential else {
            throw APITokenManagerError.noCredential
        }
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

enum APITokenManagerError: Error {
    case noOAuthSwiftInstance
    case noCredential
    case authError(Error)
}
