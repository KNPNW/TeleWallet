import UIKit

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
        window.makeKeyAndVisible()
        if true {
            startAuthVC()
        } else {
            startFirstVC()
        }
    }

    private func startFirstVC() {
        tabBarCoordinator = TabBarCoordinator(UITabBarController())
        tabBarCoordinator?.start()
    }

    private func startAuthVC() {
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator?.start()
    }
}
