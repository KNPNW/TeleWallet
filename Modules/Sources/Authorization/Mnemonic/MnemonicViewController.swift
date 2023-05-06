import UIKit
import Theme
import MnemonicGenerator

public enum MnemonicViewStates {
    case createWallet
    case confirmWallet
    case importWallet
}

public class MnemonicViewController: UIViewController {

    public var completionHandler: (([String]) -> Void)?

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var mnemonicPhraseView: MnemonicPhraseView = {
        let view = MnemonicPhraseView()
        view.completionHandler = { [weak self] value in
            self?.completionHandler?(value)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.alpha = 0
        view.tryAgainHandler = { [weak self] in
            self?.hideError()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.Colors.background

        setupUI()
        setupLayout()
    }

    public func setupMnemonicView(
        title: String,
        mainText: String,
        textButton: String,
        state: MnemonicViewStates,
        titleError: String,
        textError: String,
        mnemonicPhase: [String]? = nil
    ) {
        mnemonicPhraseView.setup(
            title: title,
            mainText: mainText,
            textButton: textButton,
            state: state,
            mnemonicPhase: mnemonicPhase
        )
        errorView.setup(
            title: titleError,
            text: textError
        )
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(mnemonicPhraseView)
        scrollView.addSubview(errorView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            mnemonicPhraseView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mnemonicPhraseView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 20),
            mnemonicPhraseView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -20),
            mnemonicPhraseView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -40),

            errorView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -20),
            errorView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

public extension MnemonicViewController {
//    func showError() {
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0,
//            animations: {
//                self.mnemonicView.alpha = 0.1
//                self.mnemonicView.isUserInteractionEnabled = false
//                self.errorView.alpha = 1
//                self.errorView.isHidden = false
//            }, completion: { _ in
//                UIView.animate(
//                    withDuration: 0.5,
//                    delay: 0,
//                    animations: {
//                        self.mnemonicView.alpha = 1
//                        self.mnemonicView.isUserInteractionEnabled = true
//                        self.errorView.alpha = 0
////                        self.errorView.isHidden = true
//                    }, completion: nil)
//            }
//        )
//    }

    func showError() {
        mnemonicPhraseView.showError()
    }
}

private extension MnemonicViewController {
    func hideError() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            animations: {
                self.mnemonicPhraseView.alpha = 1
                self.mnemonicPhraseView.isUserInteractionEnabled = true
                self.errorView.alpha = 0
                self.errorView.isHidden = true
            }, completion: nil)
    }
}
