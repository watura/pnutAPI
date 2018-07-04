import UIKit
import StreamViewController
import PnutAPI

class StreamingViewCoordinator: Coordinator {
    private let navigationController: UINavigationController

    var children: [Coordinator] = []
    private let viewController: StreamViewController
    private let viewModel: StreamViewModel

    init(presentor: UINavigationController) {
        self.navigationController = presentor
        if let vc = StreamViewController.initView() {
            self.viewController = vc
        } else {
            fatalError("Could not initialize View")
        }
        viewModel = StreamViewModel()
    }

    func start() {
        viewController.dataSource = viewModel
        navigationController.setViewControllers([viewController], animated: false)
    }
}
