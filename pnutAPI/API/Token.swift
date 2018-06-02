import Foundation
import APIKit

struct GetTokenRequest: API {
    typealias Response = TokenResponse

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "token"
    }
}

struct DeleteTokenRequest: API {
    typealias Response = TokenResponse

    var method: HTTPMethod {
        return .delete
    }

    var path: String {
        return "token"
    }
}

struct TokenResponse: Decodable {
    struct Meta: Decodable {
        let code: Int
    }

    struct Data: Decodable {
        let app: App
        let scopes: [String]
        let user: User
        let storage: Storage
    }

    struct App: Decodable {
        let id: String
        let link: String
        let name: String
    }

    struct User: Decodable {
        let id: String
        let username: String
        let timezone: String
        let name: String
        let locale: String
        let badge: Badge
        let createdAt: Date
        let type: String
        let counts: Counts
        let verified: Verified
        let followsYou: Bool
        let youBlocked: Bool
        let youFollow: Bool
        let youMuted: Bool
        let youCanFollow: Bool

    }

    struct Badge: Decodable {
        let id: String
        let name: String
    }

    struct Content: Decodable {
        let html: String
        let text: String
        let avatrImage: Image
        let coverImage: Image
    }

    struct Counts: Decodable {
        let bookmarks: Int
        let clients: Int
        let followers: Int
        let following: Int
        let posts: Int
        let users: Int
    }

    struct Verified: Decodable {
        let domain: String
        let link: URL
    }

    struct Storage: Decodable {
        let available: Int
        let total: Int
    }

    struct Image: Decodable {
        let link: URL
        let height: Int
        let width: Int
        let isDefault: Bool
    }

    let meta: Meta
    let data: Data
}
