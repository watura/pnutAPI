import UIKit
import WebKit
import Nuke

class StreamCellView: UITableViewCell {
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var body: UILabel!
}

extension StreamCellView {
    func set(iconUrl: URL?, name: String, htmlString: String, date: Date ) {
        userName.text = name

        if let url = iconUrl {
            Nuke.loadImage(with: url, into: userIcon)
        }

        body.text = htmlString

        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ssZ"
        self.date.text = formatter.string(from: date)
    }
}
