import UIKit

public protocol Initable {
    associatedtype VC
    static var storyboardName: String { get }
    static var identifier: String { get }

    static func initView() -> VC?
}

extension Initable where Self: UIViewController {
    public static func initView() -> VC? {
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? VC
    }
}
