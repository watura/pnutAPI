import Foundation

public struct Entities: Codable {
    struct Links: Codable {
        let link: String
        let text: String
        let len: Int
        let pos: Int
        let title: String?
        let description: String?
    }

    struct Mentions: Codable {
        let id: String
        let len: Int
        let pos: Int
        let text: String
        let isLeading: Bool?
        let isCopy: Bool?
    }

    struct Tags: Codable {
        let len: Int
        let pos: Int
        let text: String
    }

    let links: [Links]
    let mentions: [Mentions]
    let tags: [Tags]
}
