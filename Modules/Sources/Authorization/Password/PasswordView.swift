import UIKit
import Combine
import Theme

class PasswordView: UIView {

    private var observations = Set<AnyCancellable>()
    private var password = ""
    var fullPasswordHandler: ((String) -> Void)?

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Theme.Colors.purple
        label.font = Theme.Fonts.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let indicator: PasswordIndicator = {
        let view = PasswordIndicator()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var keyboard: PasswordKeyboard = {
        let keyboard = PasswordKeyboard()
        keyboard.keyboardHendler = { [weak self] value in
            self?.updateIndicator(text: value)
        }
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        return keyboard
    }()

    init() {
        super.init(frame: .zero)

        self.indicator.$animation.sink { animation in
            self.keyboard.isUserInteractionEnabled = !animation
        }.store(in: &observations)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(title)
        addSubview(indicator)
        addSubview(keyboard)
    }

    private func updateIndicator(text: String) {
        if text == "-1" {
            guard password.count >= 1 else { return }
            password = String(password[password.startIndex..<password.index(password.endIndex, offsetBy: -1)])
            indicator.unFillIndicator(num: password.count)
        } else {
            guard password.count < 4 else { return }
            password += text
            indicator.fillIndicator(num: password.count-1)
            if password.count == 4 {
                fullPasswordHandler?(password)
            }
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            indicator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),

            keyboard.topAnchor.constraint(greaterThanOrEqualTo: indicator.bottomAnchor, constant: 75),
            keyboard.centerXAnchor.constraint(equalTo: centerXAnchor),
            keyboard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setup(title: String) {
        self.title.text = title
    }

    func showError() {
        password = ""
        indicator.errorAnimation()
    }

    func clean() {
        password = ""
        indicator.cleanIndicator()
    }
}
