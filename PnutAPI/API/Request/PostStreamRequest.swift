import Foundation
import APIKit

public struct PostStreamsRequest: API, Paginatable, Codable {
    public let beforeId: String?
    public let sinceId: String?
    public let count: Int?

    public typealias Response = PnutResponse<[PostResponse]>

    public init(beforeId: String? = nil, sinceId: String? = nil, count: Int? = nil) {
        self.beforeId = beforeId
        self.sinceId = sinceId
        self.count = count
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "posts/streams/me"
    }

    public var parameters: Any? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try! encoder.encode(self)
        return (try? JSONSerialization.jsonObject(with: encoded, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

public struct UnifiedPostStreamsRequest: API {
    public typealias Response = PnutResponse<[PostResponse]>
    public init() {}

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "posts/streams/unified"
    }
}

public struct MentionsPostStreamsRequest: API {
    public typealias Response = PnutResponse<[PostResponse]>

    let userId: String

    public init(userId: String = "me") {
        self.userId = userId
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "users/\(userId)/mentions"
    }
}

public struct UserPostStreamsRequest: API {
    public typealias Response = PnutResponse<[PostResponse]>

    let userId: String

    public init(userId: String = "me") {
        self.userId = userId
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "users/\(userId)/posts"
    }
}

public struct GlobalPostStreamsRequest: API {
    public typealias Response = PnutResponse<[PostResponse]>
    public init() {}

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "posts/streams/global"
    }
}

public struct TagsPostStreamsRequest: API {
    public typealias Response = PnutResponse<[PostResponse]>

    let tag: String

    public init(tag: String) {
        self.tag = tag
    }

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "posts/tags/\(tag)"
    }
}
