import UIKit
import Utils
import PnutAPI

public protocol StreamDataSource: class {
    func dataForReloadData(updateValue: @escaping ([PostResponse]) -> Void)
    func dataForUpdate(newer: Bool, updateValue: @escaping (_ data: [PostResponse], _ update: [Int]?, _ insert: [Int]?, _ delete: [Int]?) -> Void)
}

public protocol StreamAction: class {
}

public protocol StreamCellAction: class {
    func didSelectRow(at indexPath: IndexPath)
}

public class StreamViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    public weak var dataSource: StreamDataSource?
    public weak var streamAction: StreamAction?
    public weak var cellAction: StreamCellAction?

    public var data: [PostResponse] = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refresh
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    func reloadData() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.dataSource?.dataForReloadData { newData in
                self?.data = newData
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    @objc func pullToRefresh(_ sender: AnyObject) {
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.dataSource?.dataForUpdate(newer: true) { data, update, insert, delete in
                DispatchQueue.main.async {
                    self?.data = data

                    self?.tableView.beginUpdates()
                    if let delete = delete?.map({ IndexPath(row: $0, section: 0)}) {
                        self?.tableView.deleteRows(at: delete, with: .automatic)
                    }
                    if let insert = insert?.map({ IndexPath(row: $0, section: 0) }) {
                        self?.tableView.insertRows(at: insert, with: .automatic)
                    }
                    if let update = update?.map({ IndexPath(row: $0, section: 0) }) {
                        self?.tableView.reloadRows(at: update, with: .automatic)
                    }
                    self?.tableView.endUpdates()
                }
            }
        }
    }
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
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell") as? StreamCellView  else { fatalError("Could not dequeue Cell") }
        let value = data[indexPath.row]

        cell.textLabel?.text = value.content?.text
        cell.detailTextLabel?.text = value.user.name

        return cell
    }
}
