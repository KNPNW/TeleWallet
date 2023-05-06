import UIKit
import Theme

class ErrorView: UIView {

    var tryAgainHandler: (() -> Void)?

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.font = Theme.Fonts.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let text: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.font = Theme.Fonts.authButton
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapedTryAgain), for: .touchUpInside)
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
        addSubview(stack)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(text)
        stack.addArrangedSubview(tryAgainButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            text.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 50),
            tryAgainButton.widthAnchor.constraint(equalToConstant: 150),
            tryAgainButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            tryAgainButton.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])
    }

    func setup(
        title: String,
        text: String
    ) {
        self.title.text = title
        self.text.text = text
    }
}

private extension ErrorView {
    @objc
    func didTapedTryAgain() {
        tryAgainHandler?()
    }
}
