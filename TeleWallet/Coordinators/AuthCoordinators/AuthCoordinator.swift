import UIKit
import Authorization
import MnemonicGenerator

class AuthCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var completionHandler: (() -> Void)?

    var moduleFactory = ModuleFactory()

    var phase: [String] = []

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        startFirst()
    }

    func startFirst() {
        let viewController = moduleFactory.createAuthModule()

        viewController.completionHandler = { [weak self] value in
            if value == "Import" {
                self?.startImport()
            } else if value == "Create" {
                self?.startCreate()
            }
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func startImport() {
        let viewController = moduleFactory.createImportWalletModule()
        viewController.completionHandler = {  [weak self] value in
            if MnemonicGenerator.isValidMnemonic(mnemonicPhase: value.joined(separator: " ")) {
                do {
                    try KeychainManager.save(
                        service: "mnemonicPhase",
                        account: UIDevice.current.identifierForVendor?.uuidString ?? "",
                        data: value.joined(separator: " ").data(using: .utf8)! )
                } catch {
                    print(error)
                }

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

    func startCreate() {
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
                do {
                    try KeychainManager.save(
                        service: "mnemonicPhase",
                        account: UIDevice.current.identifierForVendor?.uuidString ?? "",
                        data: value.joined(separator: " ").data(using: .utf8)! )
                } catch {
                    print(error)
                }
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
