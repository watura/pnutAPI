import UIKit
import ProfileViewController
import PnutAPI

class ProfileViewCoordinator: Coordinator {
    private let navigationController: UINavigationController

    var children: [Coordinator] = []
    private let viewController: ProfileViewController

    init(presentor: UINavigationController) {
        self.navigationController = presentor
        if let vc = ProfileViewController.initView() {
            self.viewController = vc
        } else {
            fatalError("Could not initialize View")
        }
        viewController.viewModel = ProfileViewModel(icon: URL(string: "http//wtr.app"), header: URL(string: "http//wtr.app"), bio: BioViewController.Bio(name: nil, id: "", bio: nil, url: nil))

        LookupUserRequest(userId: "me").request(success: {[weak self] in
            let id = $0.data.username
            let name = $0.data.name
            let iconUrl = $0.data.content.avatarImage.link
            let coverUrl = $0.data.content.coverImage.link
            let viewModel = ProfileViewModel(icon: iconUrl, header: coverUrl, bio: BioViewController.Bio(name: name, id: id, bio: nil, url: nil))
            self?.viewController.viewModel = viewModel
        }, failure: nil)
    }

    func start() {
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension ProfileViewCoordinator {
    enum User {
        case me
        case id(String)
    }
}
