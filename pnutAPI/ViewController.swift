import UIKit
import OAuthSwift
import APIKit

enum PnutAPI {
    case authorise
    case deleteToken
    case getToken
}


final class ViewController: UIViewController {
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
            GetTokenRequest().request(success: { response in
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted // リーダブルな出力
                let encoded = try! encoder.encode(response)
                print(String(data: encoded, encoding: .utf8)!)
            }, failure: { error in
                print(error)
            })
        } else {
            _ = manager.authorize(viewController: self)
        }
    }
}
