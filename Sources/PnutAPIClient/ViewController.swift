import UIKit
import Secrets
import PnutAPI

final class ViewController: UITableViewController {
    override func viewDidLoad() {
        APITokenManager.shared.setCredentials(clientId: Secrets.accessKey, clientSecret: Secrets.secretKey, callbackUrl: "pnut-callback://pnut-callback/pnut")
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
        cell.textLabel?.text = api.rawValue.capitalized
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let api = PnutAPIList.list[indexPath.row]
        api.action(viewController: self)
    }
}
