import UIKit
import Utils

public class ProfileViewController: UIViewController {}


extension ProfileViewController: StoryboardedType {
    public typealias VC = ProfileViewController

    public static var storyboardName: String { return "ProfileView" }
    public static var identifier: String { return "ProfileView" }
}
