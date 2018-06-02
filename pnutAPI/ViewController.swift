import UIKit
import OAuthSwift
import APIKit

enum PnutAPI: String {
    case authorize
    case deleteToken
    case getToken

    static var count: Int { return 3 }

    static var list: [PnutAPI] {
        return [.authorize, .deleteToken, .getToken]
    }

    func action(viewController: UIViewController) {
        switch self {
        case .authorize:
            let manager = APITokenManager()
            _ = manager.authorize(viewController: viewController)
        case .deleteToken:
            DeleteTokenRequest().request(success: { success in
                let manager = APITokenManager()
                manager.removeToken()
                viewController.title = "has Token? \(manager.hasToken)"
            })
        case .getToken:
            GetTokenRequest().request()
        }
    }
}

final class ViewController: UITableViewController {
    override func viewWillAppear(_ animated: Bool) {
        let manager = APITokenManager()

        self.title = "has Token? \(manager.hasToken)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PnutAPI.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            fatalError()
        }

        let api = PnutAPI.list[indexPath.row]
        cell.textLabel?.text = api.rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let api = PnutAPI.list[indexPath.row]
        api.action(viewController: self)
    }
}
