import UIKit
import Theme

class PasswordKeyboard: UIView {

    var keyboardHendler: ((String) -> Void)?
    private var buttons: [UIButton] = []

    private lazy var deleteView: UIView = {
        let view = UIView()
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapedDeleteButton)
        )
        view.addGestureRecognizer(gesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let deleteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "delete.left")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Theme.Colors.text
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let emptyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .equalSpacing
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
        addSubview(stack)
        createButtons()
        configureKeyboard()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createButtons() {
        for num in 0..<10 {
            let button = UIButton(num: num)
            button.tag = num
            button.addTarget(self, action: #selector(didTapedKeyboard(button:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(didDragOutside(button:)), for: .touchDragOutside)
            button.addTarget(self, action: #selector(didPressedKeyboard(button:)), for: .touchDown)
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton),
                button.widthAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton)
            ])
            buttons.append(button)
        }
        deleteView.addSubview(deleteImage)

        NSLayoutConstraint.activate([
            emptyButton.heightAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton),
            emptyButton.widthAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton),
            deleteView.heightAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton),
            deleteView.widthAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton),
            deleteImage.heightAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton/2),
            deleteImage.widthAnchor.constraint(equalToConstant: Theme.Sizes.keybordButton/2),
            deleteImage.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor),
            deleteImage.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor)
        ])
    }

    private func configureKeyboard() {
        for num in stride(from: 1, to: 10, by: 3) {
            let horizontalStack = UIStackView(
                buttons: [
                    buttons[num],
                    buttons[num+1],
                    buttons[num+2]
                ]
            )
            stack.addArrangedSubview(horizontalStack)
        }
        let horizontalStack = UIStackView(
            buttons: [
                emptyButton,
                buttons[0],
                deleteView
            ]
        )
        stack.addArrangedSubview(horizontalStack)
    }
}

private extension PasswordKeyboard {
    @objc
    private func didTapedKeyboard(button: UIView) {
        keyboardHendler?("\(button.tag)")
        button.backgroundColor = Theme.Colors.purple
    }

    @objc
    private func didDragOutside(button: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            button.backgroundColor = Theme.Colors.purple
        })
    }

    @objc
    private func didPressedKeyboard(button: UIView) {
        button.backgroundColor = Theme.Colors.lightPurple
    }

    @objc
    private func didTapedDeleteButton() {
        keyboardHendler?("-1")
    }
}

private extension UIView {
    func clickAnimation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = Theme.Colors.lightPurple
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.backgroundColor = Theme.Colors.purple
            })
        })
    }
}

private extension UIButton {
    convenience init(num: Int) {
        self.init()
        self.setTitle("\(num)", for: .normal)
        self.backgroundColor = Theme.Colors.purple
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = Theme.Fonts.keybordButton
        self.layer.cornerRadius = Theme.Sizes.keybordButton/2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension UIStackView {
    convenience init(buttons: [UIView]) {
        self.init(arrangedSubviews: buttons)
        self.spacing = 20
        self.alignment = .fill
        self.distribution = .equalCentering
    }
}
