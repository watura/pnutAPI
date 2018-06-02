import Foundation

public struct PostResponse: Codable {
    public let createdAt: Date
    public let id: String
    public let isDeleted: Bool?
    public let source: Source
    public let user: UserResponse
    public let threadId: String
    public let replyTo: String?
    public let repostOf: RepostOf?
    public let counts: Counts
    public let content: Content?
    public let youBookmarked: Bool?
    public let youReposted: Bool?

    public struct Source: Codable {
        public let id: String
        public let link: URL
        public let name: String
    }

    public struct Content: Codable {
        public let html: String
        public let text: String
        public let entities: Entities
    }

    public struct Counts: Codable {
        public let bookmarks: Int
        public let reposts: Int
        public let replies: Int
        public let threads: Int
    }

    public struct RepostOf: Codable {
        public let id: String
    }
}
