import UIKit
import Theme

class MnemonicPhraseField: UIView {

    private var textFields: [MnemonicWordField] = []

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

        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(title)
        addSubview(stack)
        createTextFields()
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
            textFields.append(MnemonicWordField(number: i, delegate: self))
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
}

extension MnemonicPhraseField {

    func insertMnemonicPhase(phase: [String]) {
        for (i, textField) in textFields.enumerated() {
            textField.insertText("\(i+1). \(phase[i])")
            textField.isEnabled(false)
        }
    }

    func insertRandomWord(phase: [String]) {
        var insertsWords = [Int]()
        for _ in 0..<9 {
            var randomNum = Int.random(in: 0..<textFields.count)
            while insertsWords.contains(randomNum) {
                randomNum = Int.random(in: 0..<textFields.count)
            }

            insertsWords.append(randomNum)
            textFields[randomNum].insertText(phase[randomNum])
            textFields[randomNum].isEnabled(false)
        }
    }

    func getMnemonicPhase() -> [String] {
        var mnemonicPhase = [String]()
        for textField in textFields {
            if let text = textField.getText() {
                mnemonicPhase.append(text)
            }
        }
        return mnemonicPhase
    }
}

extension MnemonicPhraseField: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    private func distributeWords(phase: [String]) {
        for (index, word) in phase.enumerated() {
            textFields[index].insertText(word)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let words = string.split(separator: " ").map({ (substring) in
            return String(substring)
        })
        if words.count == 12 {
            self.distributeWords(phase: words)
            self.endEditing(true)
            return false
        }
        return true
    }
}
