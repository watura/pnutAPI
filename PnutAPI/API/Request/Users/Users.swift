import Foundation
import APIKit

public enum Users {
    public enum Me {}
}

extension Users {
    public struct User: API {
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
}

extension Users {
    public struct Users: API {
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
}
