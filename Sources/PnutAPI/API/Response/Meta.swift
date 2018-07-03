import Foundation

public struct Meta: Codable {
    public let code: Int
    public let maxId: String?
    public let minId: String?
    public let more: Bool?
    public let retryIn: Int?
    public let marker: Marker?
}


public struct Marker: Codable {
    public let id: String
    public let lastReadId: String
    public let percentage: String
    public let updatedAt: Date
    public let version: String
    public let name: String
}
