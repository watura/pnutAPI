protocol Coordinator: class {
    var children: [Coordinator] { get set }

    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        children.append(coordinator)
    }

    func remove(coordinator: Coordinator) {
        children = children.filter({ $0 !== coordinator })
    }
}
