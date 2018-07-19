import UIKit
import Utils
import Nuke

public struct ProfileViewModel {
    let icon: URL?
    let header: URL?
    let bio: BioViewController.Bio!

    public init(icon: URL?, header: URL?, bio: BioViewController.Bio) {
        self.icon = icon
        self.header = header
        self.bio = bio
    }
}


public class ProfileViewController: UIViewController {
    public var viewModel: ProfileViewModel! {
        didSet {
            print("viewModel set ", viewDidLoaded)
            if let iconViewController = iconViewController {
                iconViewController.iconUrl = viewModel.icon
            }
            if let coverViewContorller = coverViewContorller {
                coverViewContorller.imageUrl = viewModel.header
            }
        }
    }

    var viewDidLoaded: Bool = false
    var iconViewController: IconViewController?
    var coverViewContorller: HeaderImageViewController?


    public override func viewDidLoad() {
        viewDidLoaded = true
    }
}


extension ProfileViewController: StoryboardedType {
    public typealias VC = ProfileViewController

    public static var storyboardName: String { return "ProfileView" }
    public static var identifier: String { return "ProfileView" }
}


extension ProfileViewController {
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "UserIconSegue":
            guard let destination = segue.destination as? IconViewController else { return }
            destination.iconUrl = viewModel.icon
            iconViewController = destination
        case "HeaderSegue":
            guard let destination = segue.destination as? HeaderImageViewController else { return }
            destination.imageUrl = viewModel.header
            coverViewContorller = destination
        default:
            return
        }
    }
}


public class IconViewController: UIViewController {
    @IBOutlet weak var imageView: CircleImageView?
    var iconUrl: URL! {
        didSet {
            loadImage()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }

    func loadImage() {
        if let imageView = imageView {
            var request = ImageRequest(url: iconUrl)
            request.process(key: "ProfileIcon", {
                return $0.rounded(with: UIColor.background)
            })
            Nuke.loadImage(with: request, into: imageView)
        }
    }

}

public class CircleImageView: UIImageView {
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("drawRect")
    }
}

public class HeaderImageViewController: UIViewController {
    var imageUrl: URL! {
        didSet {
            if let imageView = imageView {
                Nuke.loadImage(with: imageUrl, into: imageView)
            }
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        if let imageView = imageView {
            Nuke.loadImage(with: imageUrl, into: imageView)
        }
    }
    @IBOutlet weak var imageView: UIImageView?
}

public class CircleBorderedButtonViewController: UIViewController {
    var text: String!
    var onPress: (() -> Void)!
}

public class CircleBorderedButton: UIButton {
}

public class BioViewController: UIViewController {
    public struct Bio {
        let name: String?
        let id: String
        let bio: String?
        let url: URL?
        public init(name: String?, id: String, bio: String?, url: URL?) {
            self.name = name
            self.id = id
            self.bio = bio
            self.url = url
        }
    }
    var bio: Bio!
}

public class CountViewController: UIViewController {
    var name: String!
    var count: Int!
}

public class CountListtViewController: UIViewController {
    var counts: [CountViewController]!
}

extension UIImage {
    func rounded(with backgroundColor: UIColor) -> UIImage? {
        // 背景を透過ではなくす
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: .zero, size: size)
        // clear colorで背景色を塗る
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        // 丸い画像を描画する
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        // 白で背景を塗る
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
}
