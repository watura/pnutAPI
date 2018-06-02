import Foundation

struct PnutResponse<Data: Codable>: Codable {
    let meta: Meta
    let data: Data
}
