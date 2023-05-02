import UIKit
import Theme
import MnemonicGenerator

class ImportView: UIView {

    private let title: UILabel = {
        let label = UILabel()
        label.text = "Import wallet"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Theme.Colors.purple
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let helpText: UILabel = {
        let label = UILabel()
        label.text = "Insert mnemonic phase for import your wallet"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let mnemonicField: MneminicField = {
        let textField = MneminicField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let importButton: UIButton = {
        let button = UIButton()
        button.setTitle("Import", for: .normal)
        button.backgroundColor = Theme.Colors.purple
        button.titleLabel?.font = Theme.Fonts.authButton
        button.layer.cornerRadius = 20
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
        addSubview(title)
        addSubview(helpText)
        addSubview(mnemonicField)
        addSubview(importButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            helpText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 50),
            helpText.leadingAnchor.constraint(equalTo: leadingAnchor),
            helpText.trailingAnchor.constraint(equalTo: trailingAnchor),
            mnemonicField.leadingAnchor.constraint(equalTo: leadingAnchor),
            mnemonicField.trailingAnchor.constraint(equalTo: trailingAnchor),
            mnemonicField.topAnchor.constraint(equalTo: helpText.bottomAnchor, constant: 40),
            mnemonicField.heightAnchor.constraint(equalToConstant: 400),
            importButton.topAnchor.constraint(equalTo: mnemonicField.bottomAnchor, constant: 40),
            importButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            importButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            importButton.heightAnchor.constraint(equalToConstant: 60),
            importButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
