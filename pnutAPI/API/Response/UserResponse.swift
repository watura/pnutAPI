import Foundation

struct UserResponse: Decodable {
    struct Badge: Decodable {
        let id: String
        let name: String
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

    struct Content: Decodable {
        let html: String
        let text: String
        let avatarImage: Image
        let coverImage: Image
    }

    struct Image: Decodable {
        let link: URL
        let height: Int
        let width: Int
        let isDefault: Bool
    }

    let id: String
    let username: String
    let timezone: String
    let name: String
    let locale: String
    let badge: Badge
    let createdAt: Date
    let type: String
    let content: Content
    let counts: Counts
    let verified: Verified
    let followsYou: Bool
    let youBlocked: Bool
    let youFollow: Bool
    let youMuted: Bool
    let youCanFollow: Bool
}
