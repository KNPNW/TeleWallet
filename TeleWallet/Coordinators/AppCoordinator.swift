import UIKit
import Theme

class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    var tabBarCoordinator: TabBarCoordinator?
    var authCoordinator: AuthCoordinator?
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = navigationController
        navigationController.navigationBar.tintColor = Theme.Colors.text
        window.makeKeyAndVisible()

        let mnemonicPhase = KeychainManager.get(
            service: "mnemonicPhase",
            account: UIDevice.current.identifierForVendor?.uuidString ?? ""
        )
        if mnemonicPhase != nil {
            startVerificationVC()
        } else {
            startAuthVC()
        }
    }

    private func startVerificationVC() {
        let passwordCoordinator = PasswordCoordinator(navigationController: navigationController)
        childCoordinators.append(passwordCoordinator)
        passwordCoordinator.startChekPassword()
        passwordCoordinator.completionHandler = { [weak self] in
            self?.startWalletVC()
        }
    }

    private func startWalletVC() {
        tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator?.start()
    }

    private func startAuthVC() {
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator?.start()
        authCoordinator?.completionHandler = {
            self.startWalletVC()
        }
    }
}
