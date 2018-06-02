import Foundation
import APIKit

public struct GetUserRequest: API {
    public typealias Response = PnutResponse<UserResponse>

    let userId: String

    public init(userId: String) {
        self.userId = userId
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "users/" + userId
    }
}

public struct GetUsersRequest: API {
    public typealias Response = PnutResponse<[UserResponse]>

    let ids: [String]

    public init(ids: [String]) {
        self.ids = ids
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "users"
    }

    public var parameters: Any? {
        return ["ids": ids.joined(separator: ",")]
    }
}
