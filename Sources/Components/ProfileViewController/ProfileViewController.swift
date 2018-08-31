import UIKit
import Utils
import Nuke
import PnutAPI

public struct ProfileViewModel {
    let icon: URL?
    let header: URL?
    let bio: Profile!
    let counts: Counts?

    public init(icon: URL?, header: URL?, bio: Profile, counts: Counts?) {
        self.icon = icon
        self.header = header
        self.bio = bio
        self.counts = counts
    }
}


public class ProfileViewController: UIViewController {
    public var viewModel: ProfileViewModel! {
        didSet {
            if let iconViewController = iconViewController {
                iconViewController.iconUrl = viewModel.icon
            }
            if let coverViewContorller = coverViewContorller {
                coverViewContorller.imageUrl = viewModel.header
            }
            if let bioViewController = bioViewController {
                bioViewController.bio = viewModel.bio
            }
            if let countListViewController = countListViewController {
                countListViewController.counts = viewModel.counts
            }
        }
    }

    var viewDidLoaded: Bool = false
    var iconViewController: IconViewController?
    var coverViewContorller: HeaderImageViewController?
    var bioViewController: BioViewController?
    var countListViewController: CountListViewController?

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
        case "BioSegue":
            guard let destination = segue.destination as? BioViewController else { return }
            destination.bio = viewModel.bio
            bioViewController = destination
        case "CountsList":
            guard let destination = segue.destination as? CountListViewController else { return }
            destination.counts = viewModel.counts
            countListViewController = destination
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

public struct Profile {
    let name: String?
    let id: String
    let bio: String? // html
    let url: URL?
    public init(name: String?, id: String, bio: String?, url: URL?) {
        self.name = name
        self.id = id
        self.bio = bio
        self.url = url
    }
}

public class BioViewController: UIViewController {
    var bio: Profile? = Profile(name: nil, id: "", bio: nil, url: nil) {
        didSet {
            update()
        }
    }

    weak var name: NameViewController?
    weak var userId: UserIDViewController?
    weak var bioText: BioTextViewController?
    weak var urlView: URLViewController?

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Name":
            if let destination = segue.destination as? NameViewController {
                name = destination
                name?.name = bio?.name
            }
        case "UserId":
            if let destination = segue.destination as? UserIDViewController {
                userId = destination
                userId?.userId = bio?.id

            }
        case "Bio":
            if let destination = segue.destination as? BioTextViewController {
                bioText = destination
                bioText?.bioText = bio?.bio

            }
        case "Url":
            if let destination = segue.destination as? URLViewController {
                urlView = destination
                urlView?.url = bio?.url
            }
        default: fatalError()
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }

    func update() {
        name?.name = bio?.name
        userId?.userId = bio?.id
        bioText?.bioText = bio?.bio
        urlView?.url = bio?.url

    }
}

public class CountViewController: UIViewController {
    var name: String!
    var count: Int!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
}

public class CountListViewController: UIViewController {
    enum List {
        case bookmark(Int), followers(Int), following(Int), posts(Int)

        var name: String {
            return "\(self)"
        }
    }

    @IBOutlet weak var stackView: UIStackView!

    var viewControllers: [CountViewController] = []

    var counts: Counts? = nil {
        willSet {
            if let _ = newValue {
            }
        }
        didSet {
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

public class NameViewController: UIViewController {
    var name: String? {
        didSet {
            label?.text = name
        }
    }
    @IBOutlet weak var label: UILabel?

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label?.text = name
    }
}

public class UserIDViewController: UIViewController {
    var userId: String? {
        didSet {
            if let userId = userId {
                label?.text = "@" + userId
            }
        }
    }
    @IBOutlet weak var label: UILabel?

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label?.text = userId
    }
}

public class BioTextViewController: UIViewController {
    var bioText: String? {
        didSet {
            textView?.text = bioText
        }
    }
    @IBOutlet weak var textView: UITextView?
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView?.text = bioText
    }
}

public class URLViewController: UIViewController {
    var url: URL? {
        didSet {
            label?.text = url?.absoluteString
        }
    }
    @IBOutlet weak var label: UILabel?
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label?.text = url?.absoluteString
    }
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
