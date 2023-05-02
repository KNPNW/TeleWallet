import UIKit
import Theme

class MneminicField: UIView {

    private var textFields: [WordTextField] = []

    private let title: UILabel = {
        let label = UILabel()
        label.text = "Mnemonic phase"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init() {
        super.init(frame: .zero)

        addSubview(title)
        addSubview(stack)
        createTextFields()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
            stack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createTextFields() {
        for i in 1...12 {
            textFields.append(WordTextField(number: i))
        }

        for i in stride(from: 0, through: 11, by: 2) {
            let horizontalStack: UIStackView = {
                let stack = UIStackView(arrangedSubviews: [textFields[i], textFields[i+1]])
                stack.axis = .horizontal
                stack.spacing = 15
                stack.distribution = .fillEqually
                return stack
            }()
            stack.addArrangedSubview(horizontalStack)
        }
    }

    func insertMnemonicPhase(phase: [String]) {
        for (i, textField) in textFields.enumerated() {
            textField.inserWord("\(i+1). \(phase[i])")
        }
    }

}
