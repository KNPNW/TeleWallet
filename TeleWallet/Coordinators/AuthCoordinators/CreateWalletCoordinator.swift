import UIKit
import Authorization
import MnemonicGenerator

class CreateWalletCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = CreateViewController()
        let phase = MnemonicGenerator.generateMnemonicArray()
        viewController.insertPhase(phase: phase)

        navigationController.pushViewController(viewController, animated: true)
    }

}
