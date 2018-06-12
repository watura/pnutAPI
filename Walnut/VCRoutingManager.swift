import UIKit
import PnutAPI

struct VCRoutingMangar {
    static func rootViewController() -> UIViewController {
        return dummy()
    }

    static func dummy() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController ?? UIViewController()
    }
}
