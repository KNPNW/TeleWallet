import UIKit
import AudioToolbox
import MnemonicGenerator

public class WalletViewController: UIViewController {

    private var stateTable = true
    private var navigationBarConstraint: NSLayoutConstraint!
    private var walletViewBottomConstraint: NSLayoutConstraint!

    private lazy var walletNavigationBar: WalletNavigationBar = {
        let navigationBar = WalletNavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()

    private lazy var walletView: WalletView = {
        let view = WalletView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6

        print(MnemonicGenerator.generateMnemonicString())

        setupDelegate()
        setupUI()
        setupLayout()
    }

    private func setupDelegate() {
        scroll.delegate = self
    }

    private func setupUI() {
        view.addSubview(walletNavigationBar)
        scroll.addSubview(walletView)
        scroll.addSubview(contentView)
        view.addSubview(scroll)
    }

    private func setupLayout() {
        navigationBarConstraint = walletNavigationBar.heightAnchor.constraint(equalToConstant: Constants.sizeNavigationBar)
        walletViewBottomConstraint = walletView.bottomAnchor.constraint(equalTo: contentView.topAnchor)
        walletViewBottomConstraint.priority = UILayoutPriority(rawValue: 900)

        NSLayoutConstraint.activate([
            walletNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarConstraint,
            walletNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            walletNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.topAnchor.constraint(equalTo: walletNavigationBar.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            walletView.topAnchor.constraint(equalTo: walletNavigationBar.safeAreaLayoutGuide.bottomAnchor),
            walletView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            walletView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            walletViewBottomConstraint,
            contentView.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: Constants.sizeHeader),
            contentView.heightAnchor.constraint(equalToConstant: 1000),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor)
        ])
    }
}

 extension WalletViewController: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let currentContentOffsetY = scrollView.contentOffset.y

        if currentContentOffsetY > 35 && self.stateTable {
            scrollView.isScrollEnabled = false
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                animations: {
                   self.walletNavigationBar.alpha = 0
                    self.walletView.alpha = 0
                }, completion: { _ in
                    self.navigationBarConstraint.isActive = false
                    self.navigationBarConstraint = self.walletNavigationBar.heightAnchor.constraint(equalToConstant: 0)
                    self.navigationBarConstraint.isActive = true
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0,
                        animations: {
                            scrollView.contentOffset.y = Constants.sizeHeader
                            self.contentView.layer.cornerRadius = 0
                            self.updateViewConstraints()
                        }, completion: { _ in
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            self.stateTable = false
                            scrollView.isScrollEnabled = true
                        }
                    )
                }
            )
        } else if currentContentOffsetY < Constants.sizeHeader && !self.stateTable {
            navigationBarConstraint.isActive = false
            navigationBarConstraint = walletNavigationBar.heightAnchor.constraint(equalToConstant: Constants.sizeNavigationBar)
            navigationBarConstraint.isActive = true
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                animations: {
                    scrollView.contentOffset.y = 0
                    self.walletNavigationBar.alpha = 1
                    self.contentView.layer.cornerRadius = Constants.cornerRadius
                    self.walletView.alpha = 1
                    self.updateViewConstraints()
                }, completion: {_ in
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    scrollView.isScrollEnabled = true
                    self.stateTable = true
                }
            )
        }
    }
 }

private extension WalletViewController {
    enum Constants {
        static let sizeHeader: CGFloat = 200
        static let sizeNavigationBar: CGFloat = 50
        static let cornerRadius: CGFloat = 30
    }
}
