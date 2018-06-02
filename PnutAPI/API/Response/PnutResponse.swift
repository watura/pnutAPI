import Foundation

public struct PnutResponse<Data: Codable>: Codable {
    public let meta: Meta
    public let data: Data
}
