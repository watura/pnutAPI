import UIKit
import PnutAPI
import OnBoardingViewController

class VCRoutingMangar {
    static let shared = VCRoutingMangar()
    private init() {}

    func rootViewController() -> UIViewController {
        if APITokenManager.shared.hasToken {
            return dummy()
        } else {
            guard let vc = OnBoardingViewController.initView() else {
                fatalError()
            }
            vc.onBoardingAction = self
            return vc
        }
    }

    func dummy() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController ?? UIViewController()
    }
}

extension VCRoutingMangar: OnBoardingAction {
    func loginSuccess() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            print("Login Succeed")
        })
    }

    func loginFailed() {
        print("Failed")
    }
}
