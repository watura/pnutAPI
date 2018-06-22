import UIKit
import Utils


public protocol StreamDataSource: class {
    var numberOfSections: Int { get }
    func numberOfRow(section: Int ) -> Int
    func cellforRaw(at indexPath: IndexPath) -> UITableViewCell
}

public protocol StreamAction: class {
}

public protocol StreamCellAction: class {
    func didSelectRow(at indexPath: IndexPath)
}

public class StreamViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var dataSource: StreamDataSource?
    weak var cellAction: StreamCellAction?
}

extension StreamViewController: StoryboardedType {
    public typealias VC = StreamViewController
    public static var storyboardName: String { return "Stream" }
    public static var identifier: String { return "StreamView" }
}

extension StreamViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellAction?.didSelectRow(at: indexPath)
    }
}

extension StreamViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = dataSource else { fatalError("Need dataSource") }
        return dataSource.numberOfSections
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { fatalError("Need dataSource") }
        return dataSource.numberOfRow(section: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = dataSource else { fatalError("Need dataSource") }
        return dataSource.cellforRaw(at: indexPath)
    }
}
