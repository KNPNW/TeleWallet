import UIKit
import Authorization

class ModuleFactory {

    func createAuthModule() -> AuthViewController {
        AuthViewController()
    }

    func createCreateWalletModule() -> MnemonicViewController {
        let viewController = MnemonicViewController()
        viewController.setupMnemonicView(
            title: "Create Wallet",
            mainText: "Remember 12 words below",
            textButton: "I remember",
            state: .createWallet,
            titleError: "Error",
            textError: ""
        )
        return viewController
    }

    func createConfirmWalletModule(phase: [String]) -> MnemonicViewController {
        let viewController = MnemonicViewController()
        viewController.setupMnemonicView(
            title: "Confirm phase",
            mainText: "Fill in the gaps with the words that were given earlier",
            textButton: "Confirm",
            state: .confirmWallet,
            titleError: "Error",
            textError: "Not correct mnemonic phase",
            mnemonicPhase: phase
        )
        return viewController
    }

    func createImportWalletModule() -> MnemonicViewController {
        let viewController = MnemonicViewController()
        viewController.setupMnemonicView(
            title: "Import Wallet",
            mainText: "Insert mnemonic phase for import your wallet",
            textButton: "Import",
            state: .importWallet,
            titleError: "Error",
            textError: "Not correct mnemonic phase"
        )
        return viewController
    }

    func createPasswordModule() -> PasswordViewController {
        let viewController = PasswordViewController()
        viewController.setupPasswordView(title: "Enter password")
        return viewController
    }

    func createConfirmPasswordModule() -> PasswordViewController {
        let viewController = PasswordViewController()
        viewController.setupPasswordView(title: "Confirm password")
        return viewController
    }
}
