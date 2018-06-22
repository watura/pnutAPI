import UIKit
import StreamViewController

class StreamingViewCoordinator: Coordinator {
    private let navigationController: UINavigationController

    var children: [Coordinator] = []
    private let viewController: StreamViewController

    init(presentor: UINavigationController) {
        self.navigationController = presentor
        if let vc = StreamViewController.initView() {
            self.viewController = vc
        } else {
            fatalError("Could not initialize View")
        }
    }

    func start() {
        navigationController.setViewControllers([viewController], animated: false)
    }
}
