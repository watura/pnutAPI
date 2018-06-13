import UIKit
import PnutAPI
import PostViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
        APITokenManager.shared.removeToken()
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Navigation",
            let nav = segue.destination as? RootNavigationViewController {
            if let postView = PostViewController.initView() {
                postView.postAction = self
                nav.pushViewController(postView, animated: true)
            }
        }
    }
}

extension ViewController: PostAction {
    func cancel() {
    }

    func compelete(text: String) {
        let postBody = PostBody(text: text)
        PostRequest(postBody: postBody).request()
    }

    func validate(text: String) -> Bool {
        return true
    }
}
