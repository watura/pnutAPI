import UIKit
import Utils

public class ProfileViewController: UIViewController {}


extension ProfileViewController: StoryboardedType {
    public typealias VC = ProfileViewController

    public static var storyboardName: String { return "ProfileView" }
    public static var identifier: String { return "ProfileView" }
}


public class IconViewController: UIViewController {
    var iconUrl: URL!
    @IBOutlet weak var imageView: UIImageView!
}

public class HeaderImageViewController: UIViewController {
    var imageUrl: URL!
    @IBOutlet weak var imageView: UIImageView!
}

public class CircleBorderedButtonViewController: UIViewController {
    var text: String!
    var onPress: (() -> Void)!
}

public class BioViewController: UIViewController {}
