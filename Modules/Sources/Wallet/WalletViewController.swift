//
//  WalletViewController.swift
//  
//
//  Created by Кирилл Падалица on 23.04.2023.
//

import UIKit

public class WalletViewController: UIViewController {

    private lazy var walletView: WalletView = {
        let view = WalletView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        title = "Wallet"
        scroll.delegate = self
        setupUI()
        setupLayout()
    }

    private func setupUI() {
        scroll.addSubview(walletView)
        scroll.addSubview(contentView)
        view.addSubview(scroll)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            walletView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            walletView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            walletView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 200),
            contentView.heightAnchor.constraint(equalToConstant: 1000),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])

        let walletViewBottomConstraint: NSLayoutConstraint!
        walletViewBottomConstraint = walletView.bottomAnchor.constraint(equalTo: contentView.topAnchor)
        walletViewBottomConstraint.priority = UILayoutPriority(rawValue: 900)
        walletViewBottomConstraint.isActive = true
    }
}

extension WalletViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            walletView.alpha = 1
        }

        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= 200 {
                walletView.alpha = (200-scrollView.contentOffset.y)/250
        }

        if scrollView.contentOffset.y >= 200 {
            walletView.alpha = 0
        }
    }
}
