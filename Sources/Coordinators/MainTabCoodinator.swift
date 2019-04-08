import UIKit

class MainTabCoordinator: Coordinator {
    var children: [Coordinator] = []
    private let navigationController: UINavigationController
    private let tabBar: UITabBarController

    init(presentor: UINavigationController) {
        self.navigationController = presentor
        self.tabBar =  UITabBarController()
    }

    func start() {
        let streamingNavigation = UINavigationController()
        streamingNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        let streamCoordinator = StreamingViewCoordinator(presentor: streamingNavigation)
        let profileCoordinator = ProfileViewCoordinator(presentor: streamingNavigation)
        add(coordinator: profileCoordinator)
        streamingNavigation.isNavigationBarHidden = true
        self.tabBar.setViewControllers([streamingNavigation], animated: true)
        self.tabBar.tabBar.isHidden = true
        navigationController.setViewControllers([self.tabBar], animated: true)
        profileCoordinator.start()
    }
}
