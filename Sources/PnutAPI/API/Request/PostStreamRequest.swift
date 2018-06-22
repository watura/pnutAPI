import Foundation
import APIKit

public struct PostStreamsRequest: API {
    public typealias Response = PnutResponse<[PostResponse]>
    public init() {}

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "posts/streams/me"
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
