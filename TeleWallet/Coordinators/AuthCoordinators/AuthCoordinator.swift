import UIKit
import Authorization

class AuthCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = AuthViewController()

        viewController.completionHandler = { [weak self] value in
            if value == "Import" {
                self?.startImport()
            } else if value == "Create" {
                let createWalletCoordinator = CreateWalletCoordinator(navigationController: self!.navigationController)
                createWalletCoordinator.start()
            }
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func startImport() {
        let viewController = ImportWalletViewController()

        navigationController.pushViewController(viewController, animated: true)
    }
}
