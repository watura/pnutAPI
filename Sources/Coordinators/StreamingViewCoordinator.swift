import UIKit
import StreamViewController
import PnutAPI

class StreamingViewCoordinator: Coordinator {
    private let navigationController: UINavigationController

    var children: [Coordinator] = []
    private let viewController: StreamViewController
    var firstId: String?
    var lastId: String?

    init(presentor: UINavigationController) {
        self.navigationController = presentor
        if let vc = StreamViewController.initView() {
            self.viewController = vc
        } else {
            fatalError("Could not initialize View")
        }
    }

    func start() {
        viewController.dataSource = self
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension StreamingViewCoordinator: StreamDataSource {
    func dataForUpdate(newer: Bool, updateValue: @escaping ([PostResponse], [Int]?, [Int]?, [Int]?) -> Void) {
        PostStreamsRequest().request(success: { response in
            print("No update supported")
        }, failure: {
            print($0)
        })
    }

    func dataForReloadData(updateValue: @escaping ([PostResponse]) -> Void) {
        PostStreamsRequest().request(success: { [weak self] response in
            if let id = response.data.first?.id {
                self?.firstId = id
            }
            if let id = response.data.last?.id {
                self?.lastId = id
            }
            updateValue(response.data)
        }, failure: {
            print($0)
        })
    }

    func dataForUpdate(newer: Bool) -> (data: [PostResponse], update: [Int]?, insert: [Int]?, delete: [Int]?) {
        return (data: [], update: nil, insert: nil, delete: nil)
    }
}
