import UIKit
import Authorization
import MnemonicGenerator

class CreateWalletCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var completionHandler: (() -> Void)?

    var moduleFactory = ModuleFactory()

    var phase: [String] = []

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        startCreateWallet()
    }

    func startCreateWallet() {
        let viewController = moduleFactory.createCreateWalletModule()
        viewController.completionHandler = { [weak self] value in
            self?.phase = value
            self?.startCheckMnemonicPhase()
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func startCheckMnemonicPhase() {
        let viewController = moduleFactory.createConfirmWalletModule(phase: phase)
        viewController.completionHandler = { [weak self] value in
            if value == self?.phase {
                let passwordCoordinator = PasswordCoordinator(navigationController: self!.navigationController)
                self?.childCoordinators.append(passwordCoordinator)
                passwordCoordinator.start()
                passwordCoordinator.completionHandler = {
                    self?.completionHandler?()
                }
            } else {
                viewController.showError()
            }
        }

        navigationController.pushViewController(viewController, animated: true)
    }

}
