public protocol HasObject: Encodable {
    associatedtype Object
    var object: Object { get }
}
