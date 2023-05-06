import UIKit
import Theme

class MnemonicWordField: UIView {

    private let view: UIView = {
        let view = UIView()
        view.layer.borderColor = Theme.Colors.purple.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init(number: Int, delegate: UITextFieldDelegate?) {
        super.init(frame: .zero)

        textField.delegate = delegate
        textField.tag = number
        textField.placeholder = "\(number)"
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(view)
        addSubview(textField)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalTo: view.heightAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func insertText(_ text: String) {
        textField.text = text
    }

    func getText() -> String? {
        textField.text?.lowercased()
    }

    func isEnabled(_ value: Bool) {
        textField.isEnabled = value
    }
}
