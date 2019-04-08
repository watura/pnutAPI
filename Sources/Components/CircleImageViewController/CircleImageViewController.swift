import UIKit
import Nuke
import Color
import Utils

public class CircleImageViewController: UIViewController {
    @IBOutlet public weak var imageView: CircleImageView!

    public var iconUrl: URL? {
        didSet {
            loadImage()
        }
    }

    public var color: UIColor = UIColor.white {
        didSet {
            if let imageView = imageView,
                let image = imageView.image {
                imageView.image = image.rounded(with: color)
            }
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }

    func loadImage() {
        if let imageView = imageView,
            let url = iconUrl {
            var request = ImageRequest(url: url)
            request.process(key: "ProfileIcon\(arc4random())", {[color] in
                return $0.rounded(with: color)
            })
            Nuke.loadImage(with: request, into: imageView)
        }
    }
}

@IBDesignable public class CircleImageView: UIImageView {
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if let image = UIImage.image(from: UIColor.green, size: self.frame.size) {
            let insetSize = rect.width * 0.15
            image.draw(in: rect.insetBy(dx: insetSize, dy: insetSize))
            self.image = image
        }
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

    static func image(from color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { UIGraphicsEndImageContext();return nil}
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { UIGraphicsGetImageFromCurrentImageContext(); return nil}
        UIGraphicsEndImageContext()
        return image
    }
}
