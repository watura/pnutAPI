import UIKit
import PnutAPI
import OnBoardingViewController
import StreamViewController

class AppCordinator: Coordinator {
    func start() {
        if isAuthenticated {
            showOnboardingViewController()
        } else {
            showOnboardingViewController()
        }
    }

    private let window: UIWindow
    private let navigationController: UINavigationController
    private var onbordingCoordinator: OnBoardingViewCoordinator?
    var children: [Coordinator] = []

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window.rootViewController = navigationController
    }
}

extension AppCordinator {
    var isAuthenticated: Bool {
        return APITokenManager.shared.hasToken
    }
}

extension AppCordinator: OnBoardingCoordinatorAction {
    func showOnboardingViewController() {
        let coordinator = OnBoardingViewCoordinator(presentor: navigationController, delegate: self)
        coordinator.start()
        add(coordinator: coordinator)
    }

    func onBoardingScuccess(coordinator: OnBoardingViewCoordinator) {
        remove(coordinator: coordinator)
        showStreamViewControler()
    }

    func onBoardingFailed(coordinator: OnBoardingViewCoordinator, error: Error) {
        print(error)
    }
}

extension AppCordinator: StreamAction {
    func showStreamViewControler() {
        let coordinator = StreamingViewCoordinator(presentor: navigationController)
        coordinator.start()
        add(coordinator: coordinator)
    }
}
