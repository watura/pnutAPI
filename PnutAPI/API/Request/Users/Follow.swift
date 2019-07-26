import Foundation
import APIKit

extension Users.Follow {
    public struct Following: API {
        public typealias Response = PnutResponse<UserResponse>

        let userId: String

        public init(userId: String) {
            self.userId = userId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "users/\(userId)/following"
        }
    }
}

extension Users.Follow {
    public struct Followers: API {
        public typealias Response = PnutResponse<[UserResponse]>

        let userId: String

        public init(userId: String) {
            self.userId = userId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "users/\(userId)/followers"
        }
    }
}
