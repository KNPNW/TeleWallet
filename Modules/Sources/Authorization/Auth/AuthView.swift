import UIKit
import Theme

class AuthView: UIView {

    var completionHandler: ((String) -> Void)?

    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "teleWalletLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var createWalletButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Wallet", for: .normal)
        button.backgroundColor = Theme.Colors.purple
        button.titleLabel?.font = Theme.Fonts.authButton
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.addTarget(self, action: #selector(didPressCreateWallet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var importWalletButton: UIButton = {
        let button = UIButton()
        button.setTitle("Import Wallet", for: .normal)
        button.backgroundColor = Theme.Colors.background
        button.setTitleColor(Theme.Colors.purple, for: .normal)
        button.titleLabel?.font = Theme.Fonts.authButton
        button.addTarget(self, action: #selector(didPressImportWallet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(frame: .zero)

        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(logo)
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(createWalletButton)
        buttonStack.addArrangedSubview(importWalletButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 250),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            createWalletButton.heightAnchor.constraint(equalToConstant: 65),
            importWalletButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}

private extension AuthView {
    @objc
    private func didPressImportWallet() {
        completionHandler?("Import")
    }

    @objc
    private func didPressCreateWallet() {
        completionHandler?("Create")
    }
}
