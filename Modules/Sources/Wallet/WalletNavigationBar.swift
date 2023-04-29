import UIKit
import Theme

class WalletNavigationBar: UIView {

    private let title: UILabel = {
        let label = UILabel()
        label.text = "TeleWallet"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let chainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
//        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let chainTitle: UILabel = {
        let label = UILabel()
        label.text = "BSC"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let chainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(chainView)
        chainView.addSubview(chainImageView)
        chainView.addSubview(chainTitle)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            chainView.topAnchor.constraint(equalTo: topAnchor),
            chainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            chainView.widthAnchor.constraint(equalToConstant: Constants.sizeChainButton),
            chainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.heightAnchor.constraint(equalTo: heightAnchor),
            title.widthAnchor.constraint(equalToConstant: 200),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            title.trailingAnchor.constraint(equalTo: chainView.leadingAnchor),
            chainImageView.widthAnchor.constraint(equalToConstant: Constants.sizeChainImage),
            chainImageView.heightAnchor.constraint(equalToConstant: Constants.sizeChainImage),
            chainImageView.centerYAnchor.constraint(equalTo: chainView.centerYAnchor),
            chainImageView.trailingAnchor.constraint(equalTo: chainView.trailingAnchor, constant: -10),
            chainTitle.centerYAnchor.constraint(equalTo: chainView.centerYAnchor),
            chainTitle.leadingAnchor.constraint(equalTo: chainView.leadingAnchor, constant: 20),
            chainTitle.trailingAnchor.constraint(equalTo: chainImageView.leadingAnchor, constant: -10)
        ])
    }
}

private extension WalletNavigationBar {
    enum Constants {
        static let sizeChainButton: CGFloat = 100
        static let sizeChainImage: CGFloat = 20
    }
}
