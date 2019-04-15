import Foundation
import APIKit

extension Users.Me {
    public struct UserObject: Codable {
        struct Content: Codable {
            let text: String
        }

        let timezone: String
        let locale: String
        let name: String
        let content: Content

        public init(timezone: String, locale: String, name: String = "", text: String = "") {
            self.timezone = timezone
            self.locale = locale
            self.name = name
            self.content = Content(text: text)
        }
    }
}

extension Users.Me {
    public struct Put: API, HasObject {
        public typealias Response = PnutResponse<UserResponse>
        public typealias Object = UserObject

        public let object: UserObject

        public init(object: UserObject) {
            self.object = object
        }

        public var method: HTTPMethod {
            return .put
        }

        public var path: String {
            return "users/me"
        }
    }
}
