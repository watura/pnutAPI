import UIKit
import PnutAPI

final class ViewController: UITableViewController {
    override func viewDidLoad() {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist" ),
            let plist = NSDictionary(contentsOfFile: filePath) else {
                fatalError("Could not load plist")
        }

        guard let clientId = plist["PnutClientID"] as? String,
            let clientSecret = plist["PnutClientSecret"] as? String else {
                fatalError("Could not read secrets")
        }
        APITokenManager.shared.setCredentials(clientId: clientId, clientSecret: clientSecret, callbackUrl: "pnut-callback://pnut-callback/pnut")
    }

    override func viewWillAppear(_ animated: Bool) {
        let manager = APITokenManager.shared

        self.title = "has Token? \(manager.hasToken)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PnutAPIList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            fatalError()
        }

        let api = PnutAPIList.list[indexPath.row]
        cell.textLabel?.text = api.rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let api = PnutAPIList.list[indexPath.row]
        api.action(viewController: self)
    }
}
