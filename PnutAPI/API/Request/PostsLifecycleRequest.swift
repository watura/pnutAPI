import Foundation
import APIKit

public struct PostBody: Codable {
    let text: String
    let replyTo: String?
    let isNsfw: Bool?
    let entities: Entities?

    public struct Entities: Codable {
        let parseLinks: Bool?
        let parseMarkdownLinks: Bool?

        public init(parseLinks: Bool? = nil, parseMarkdownLinks: Bool? = nil) {
            self.parseLinks = parseLinks
            self.parseMarkdownLinks = parseMarkdownLinks
        }
    }

    public init(text: String, replyTo: String? = nil, isNsfw: Bool? = nil, entities: Entities? = nil) {
        self.text = text
        self.replyTo = replyTo
        self.isNsfw = isNsfw
        self.entities = entities
    }
}

public struct PostRequest: API {
    public typealias Response = PnutResponse<PostResponse>

    public init(postBody: PostBody) {
        self.postBody = postBody
    }

    let postBody: PostBody

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "posts"
    }

    public var parameters: Any? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encoded = try! encoder.encode(postBody)
        return (try? JSONSerialization.jsonObject(with: encoded, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

public struct RevisePostRequest: API {
    public typealias Response = PnutResponse<PostResponse>

    public init(id: String, postBody: PostBody) {
        self.id = id
        self.postBody = postBody
    }

    let postBody: PostBody
    let id: String

    public var method: HTTPMethod {
        return .put
    }

    public var path: String {
        return "posts/\(id)"
    }

    public var parameters: Any? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encoded = try! encoder.encode(postBody)
        return (try? JSONSerialization.jsonObject(with: encoded, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}


public struct DeletePostRequest: API {
    public typealias Response = PnutResponse<PostResponse>

    public init(id: String) {
        self.id = id
    }

    let id: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "posts/\(id)"
    }
}
