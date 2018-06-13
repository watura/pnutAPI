import UIKit
import Utils


public protocol StreamDataSource {
}

public protocol StreamAction {
}

public protocol StreamCellAction {
}

public class StreamViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
}

extension StreamViewController: InitableType {
    public typealias VC = StreamViewController
    public static var storyboardName: String { return "Stream" }
    public static var identifier: String { return "StreamView" }
}
