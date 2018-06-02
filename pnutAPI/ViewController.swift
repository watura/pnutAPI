import UIKit
import OAuthSwift

class ViewController: UIViewController {
    var oauthswift: OAuth2Swift?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchUpInside(_ sender: Any) {
        let manager = APITokenManager()
        if manager.hasToken {
            manager.removeToken()
        } else {
            _ = manager.authorize(viewController: self)
        }
    }
}
