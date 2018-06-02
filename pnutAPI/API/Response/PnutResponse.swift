import Foundation

struct PnutResponse<Data: Decodable>: Decodable {
    let meta: Meta
    let data: Data
}
