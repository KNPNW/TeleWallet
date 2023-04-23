import UIKit
import Wallet
import Market
import Settings

class TabBarCoordinator {

    var tabBarController: UITabBarController

    required init(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        let wallet = WalletViewController()
        let market = MarketViewController()
        let settings = SettingsViewController()
        let walletNC = UINavigationController(rootViewController: wallet)
        let marketNC = UINavigationController(rootViewController: market)
        let settingsNC = UINavigationController(rootViewController: settings)

        walletNC.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(systemName: "creditcard"), tag: 0)
        marketNC.tabBarItem = UITabBarItem(title: "Market", image: UIImage(systemName: "arrow.up.arrow.down"), tag: 1)
        settingsNC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 2)
        let controllers = [walletNC, marketNC, settingsNC]

        controllers.forEach { $0.navigationBar.prefersLargeTitles = true }

        self.prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.tabBar.isTranslucent = false
//        tabBarController.tabBar.tintColor = Theme.Colors.tabBarItemColor
//        tabBarController.tabBar.backgroundColor = Theme.Colors.background
        tabBarController.setViewControllers(tabControllers, animated: true)
    }
}
