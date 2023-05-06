import UIKit
import Authorization
class PasswordCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    var completionHandler: (() -> Void)?

    var userPassword: String?
    var moduleFactory = ModuleFactory()

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        startCreatePassword()
    }

    func startCreatePassword () {
        let viewController = moduleFactory.createPasswordModule()
        viewController.complitionHandler = {[weak self] password in
            self?.userPassword = password
            self?.startConfirmPassword()
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func startConfirmPassword() {
        let viewController = moduleFactory.createConfirmPasswordModule()
        viewController.complitionHandler = {[weak self] password in
            if self?.userPassword! != password {
                viewController.errorPassword()
            } else {
                do {
                    try KeychainManager.save(
                        service: "localPassword",
                        account: UIDevice.current.identifierForVendor?.uuidString ?? "",
                        data: password.data(using: .utf8)!)
                } catch {
                    print(error)
                }
                self?.completionHandler?()
            }
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func startChekPassword() {
        let viewController = moduleFactory.createPasswordModule()

        let password = KeychainManager.get(
            service: "localPassword",
            account: UIDevice.current.identifierForVendor?.uuidString ?? ""
        )
        let localPassword = String(decoding: password ?? Data(), as: UTF8.self)
        viewController.complitionHandler = {[weak self] password in
            if localPassword != password {
                viewController.errorPassword()
            } else {
                print("tyt")
                self?.completionHandler?()
            }
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
