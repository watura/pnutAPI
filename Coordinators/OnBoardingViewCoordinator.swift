import UIKit
import OnBoardingViewController

protocol OnBoardingCoordinatorAction {
    func onBoardingScuccess(coordinator: OnBoardingViewCoordinator)
    func onBoardingFailed(coordinator: OnBoardingViewCoordinator, error: Error)
}

class OnBoardingViewCoordinator: Coordinator {
    private let navigationController: UINavigationController

    var children: [Coordinator] = []
    private let viewController: OnBoardingViewController
    private let delegate: OnBoardingCoordinatorAction

    init(presentor: UINavigationController, delegate: OnBoardingCoordinatorAction) {
        self.navigationController = presentor
        if let viewController = OnBoardingViewController.initView() {
            self.viewController = viewController
        } else {
            fatalError("Could not init ViewController")
        }
        self.delegate = delegate
        viewController.onBoardingAction = self
    }

    func start() {
        self.navigationController.setViewControllers([viewController], animated: false)
    }
}

extension OnBoardingViewCoordinator: OnBoardingAction {
    func onBoardingSuccess() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {[weak self] in
            print("Login Succeed")
            if let weakSelf = self {
                weakSelf.delegate.onBoardingScuccess(coordinator: weakSelf)
            }
        })
    }

    func onBoardingFailed(_ error: Error) {
        self.delegate.onBoardingFailed(coordinator: self, error: error)
    }
}
