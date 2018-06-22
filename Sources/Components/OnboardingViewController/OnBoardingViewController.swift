import UIKit
import PnutAPI
import Utils

public protocol OnBoardingAction: class {
    func onBoardingSuccess()
    func onBoardingFailed(_ error: Error)
}

public class OnBoardingViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    public weak var onBoardingAction: OnBoardingAction?
}

extension OnBoardingViewController: StoryboardedType {
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
            _ = try manager.authorize(viewController: self, success: action.onBoardingSuccess, failed: action.onBoardingFailed)
        } catch let error {
            action.onBoardingFailed(error)
        }
    }
}
