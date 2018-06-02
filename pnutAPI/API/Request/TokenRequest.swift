import Foundation
import APIKit

struct GetTokenRequest: API {
    typealias Response = PnutResponse<TokenResponse>

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "token"
    }
}

struct DeleteTokenRequest: API {
    typealias Response = PnutResponse<TokenResponse>

    var method: HTTPMethod {
        return .delete
    }

    var path: String {
        return "token"
    }
}
