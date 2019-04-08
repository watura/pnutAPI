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
        viewController.viewModel = ProfileViewModel(icon: URL(string: "http//wtr.app"), header: URL(string: "http//wtr.app"), bio: Profile(name: nil, id: "", bio: nil, url: nil), counts: nil)

        LookupUserRequest(userId: "me").request(success: {[weak self] in
            let id = $0.data.username
            let name = $0.data.name
            let iconUrl = $0.data.content.avatarImage.link
            let coverUrl = $0.data.content.coverImage.link
            let bio = $0.data.content.text ?? ""
            let url = $0.data.verified?.link
            let profile = Profile(name: name, id: id, bio: bio, url: url)
            let counts = $0.data.counts
            let viewModel = ProfileViewModel(icon: iconUrl, header: coverUrl, bio: profile, counts: counts)

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
