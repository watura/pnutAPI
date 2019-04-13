public protocol Paginatable {
    var beforeId: String? { get }
    var sinceId: String? { get }
    var count: Int? { get }
}
