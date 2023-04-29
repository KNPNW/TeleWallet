import UIKit
import Theme

class WalletButton: UIView {

    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius

        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.labelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        layer.cornerRadius = Constants.cornerRadius

        setupUI(image: image, title: title)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(image: UIImage, title: String) {
        self.image.image = image
        label.text = title

        addSubview(view)
        view.addSubview(self.image)
        addSubview(label)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.widthAnchor.constraint(equalToConstant: Constants.sizeImage*1.6),
            view.heightAnchor.constraint(equalToConstant: Constants.sizeImage*1.6),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: Constants.sizeImage),
            image.heightAnchor.constraint(equalToConstant: Constants.sizeImage),
            label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

private extension WalletButton {
    enum Constants {
        static let backgroundColor: UIColor = .white
        static let sizeImage: CGFloat = 30
        static let cornerRadius: CGFloat = 15
        static let labelFont: UIFont = Theme.Fonts.walletButton
    }
}
