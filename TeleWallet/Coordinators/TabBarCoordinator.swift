import UIKit
import Wallet
import Market
import Settings
import Theme

class TabBarCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController = UITabBarController()

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let wallet = WalletViewController()
        let market = MarketViewController()
        let settings = SettingsViewController()

        wallet.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(systemName: "creditcard"), tag: 0)
        market.tabBarItem = UITabBarItem(title: "Market", image: UIImage(systemName: "arrow.up.arrow.down"), tag: 1)
        settings.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 2)
        let controllers = [wallet, market, settings]

        self.navigationController.navigationBar.isHidden = true
        self.tabBarController.tabBar.backgroundColor = Theme.Colors.background
        self.tabBarController.tabBar.tintColor = Theme.Colors.purple
        self.tabBarController.setViewControllers(controllers, animated: true)

        self.navigationController.setViewControllers([tabBarController], animated: true)

        wallet.complitionHandler = { [weak self] in
            do {
                try KeychainManager.delete(
                    service: "mnemonicPhase",
                    account: UIDevice.current.identifierForVendor?.uuidString ?? ""
                )
            } catch {
                print(error)
            }

        }
    }

}
