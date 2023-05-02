import UIKit
import Theme

class WordTextField: UIView {

    private let view: UIView = {
        let view = UIView()
        view.layer.borderColor = Theme.Colors.purple.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init(number: Int) {
        super.init(frame: .zero)
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

    func inserWord(_ word: String) {
        textField.text = word
        textField.isEnabled = false
    }
}
