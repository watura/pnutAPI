import UIKit
import Nuke

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
    @IBOutlet weak var imageView: HeaderImageView?
}

class HeaderImageView: UIImageView {
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 48

        print(size)

        return size
    }
}
