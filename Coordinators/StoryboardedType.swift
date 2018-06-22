import UIKit

public protocol StoryboardedType {
    associatedtype VC
    static var storyboardName: String { get }
    static var identifier: String { get }

    static func initialize() -> VC?
}

extension StoryboardedType where Self: UIViewController {
    public static func initialize() -> VC? {
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? VC
    }
}
