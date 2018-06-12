import UIKit
import PnutAPI

public protocol OnBoardingAction {
    func loginSuccess() -> Void
    func loginFailed() -> Void
}

public class OnBoardingViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    public var onBoardingAction: OnBoardingAction?
}

extension OnBoardingViewController {
    public static func initView() -> OnBoardingViewController? {
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as? OnBoardingViewController
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
