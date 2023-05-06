import UIKit
import MnemonicGenerator
import Theme

class MnemonicPhraseView: UIView {

    var completionHandler: (([String]) -> Void)?
    var state: MnemonicViewStates? {
        didSet {
            setupMnemonicField()
        }
    }
    private var mnemonicPhase: [String]?

    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Theme.Colors.purple
        label.font = Theme.Fonts.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let mnemonicField: MnemonicPhraseField = {
        let textField = MnemonicPhraseField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.Colors.purple
        button.titleLabel?.font = Theme.Fonts.authButton
        button.layer.cornerRadius = Theme.StyleElements.buttonCornerRadius
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
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
        addSubview(subtitle)
        addSubview(mnemonicField)
        addSubview(button)
    }

    func setup(
        title: String,
        mainText: String,
        textButton: String,
        state: MnemonicViewStates,
        mnemonicPhase: [String]? = nil
    ) {
        self.title.text = title
        self.subtitle.text = mainText
        self.button.setTitle(textButton, for: .normal)
        self.mnemonicPhase = mnemonicPhase
        self.state = state
    }

    private func setupMnemonicField() {
        switch state {
        case .createWallet:
            mnemonicPhase = MnemonicGenerator.generateMnemonicArray()
            mnemonicField.insertMnemonicPhase(phase: mnemonicPhase ?? [""])
        case .confirmWallet:
            mnemonicField.insertRandomWord(phase: mnemonicPhase ?? [""])
        default:
            return
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 50),
            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            mnemonicField.leadingAnchor.constraint(equalTo: leadingAnchor),
            mnemonicField.trailingAnchor.constraint(equalTo: trailingAnchor),
            mnemonicField.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 40),
            mnemonicField.heightAnchor.constraint(equalToConstant: 400),
            button.topAnchor.constraint(equalTo: mnemonicField.bottomAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func showError() {
        button.shake()
        button.backgroundColor = Theme.Colors.error
        UIView.animate(withDuration: 1.0, animations: {
            self.button.backgroundColor = Theme.Colors.purple
        })
    }
}

extension UIButton {

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

private extension MnemonicPhraseView {
    @objc
    private func didPressButton() {
        switch state {
        case .createWallet:
            completionHandler?(mnemonicPhase ?? [""])
        default:
            completionHandler?(mnemonicField.getMnemonicPhase())
        }
    }
}
