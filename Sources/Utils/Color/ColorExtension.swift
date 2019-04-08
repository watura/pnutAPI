import UIKit

extension UIColor {
    public static var background: UIColor {
        guard let color = UIColor(named: "Background") else { fatalError()}
        return color
    }
}
