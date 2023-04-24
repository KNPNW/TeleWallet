import UIKit
import Theme

class WalletView: UIView {

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$4,232.82"
        label.font = Theme.Fonts.balance
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let walletButtons: WalletButtonsControl = {
        let view = WalletButtonsControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(balanceLabel)
        addSubview(walletButtons)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            balanceLabel.widthAnchor.constraint(equalTo: widthAnchor),
            balanceLabel.heightAnchor.constraint(equalToConstant: 60),
            walletButtons.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10),
            walletButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            walletButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            walletButtons.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
