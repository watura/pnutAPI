import Foundation

public struct UserResponse: Codable {
    public struct Badge: Codable {
        public let id: String
        public let name: String
    }

    public struct Verified: Codable {
        public let domain: String?
        public let link: URL?
    }

    public struct Content: Codable {
        public let html: String?
        public let text: String?
        public let avatarImage: Image
        public let coverImage: Image
    }

    public struct Image: Codable {
        public let link: URL
        public let height: Int
        public let width: Int
        public let isDefault: Bool
    }

    public let id: String
    public let username: String
    public let timezone: String
    public let name: String?
    public let locale: String
    public let badge: Badge?
    public let createdAt: Date
    public let type: String
    public let content: Content
    public let counts: Counts
    public let verified: Verified?
    public let followsYou: Bool
    public let youBlocked: Bool
    public let youFollow: Bool
    public let youMuted: Bool
    public let youCanFollow: Bool
}
