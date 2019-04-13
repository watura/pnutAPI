import Foundation
import APIKit

public struct GetTokenRequest: API {
    public typealias Response = PnutResponse<TokenResponse>
    public init() {}

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "token"
    }
}

public struct DeleteTokenRequest: API {
    public init() {}

    public typealias Response = PnutResponse<TokenResponse>

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "token"
    }
}
