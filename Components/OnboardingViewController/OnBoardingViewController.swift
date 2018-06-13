import UIKit
import PnutAPI
import Utils

public protocol OnBoardingAction {
    func loginSuccess() -> Void
    func loginFailed() -> Void
}

public class OnBoardingViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    public var onBoardingAction: OnBoardingAction?
}

extension OnBoardingViewController: InitableType {
    public typealias VC = OnBoardingViewController

    public static var storyboardName: String {
        return "OnBoarding"
    }

    public static var identifier: String {
        return "OnBoardingViewController"
    }

}

extension OnBoardingViewController {
    @IBAction func loginButtonPressed(_ sender: Any) {
        let manager = APITokenManager.shared
        guard let action = onBoardingAction else { fatalError("") }
        do {
            _ = try manager.authorize(viewController: self, success: action.loginSuccess, failed: action.loginFailed)
        } catch {
            action.loginFailed()
        }
    }
}
