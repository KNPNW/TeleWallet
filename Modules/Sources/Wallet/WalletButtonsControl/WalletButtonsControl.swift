//
//  WalletButtonsControl.swift
//  
//
//  Created by Кирилл Падалица on 24.04.2023.
//

import UIKit

class WalletButtonsControl: UIView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let sendButton: WalletButton = {
        let button = WalletButton(image: UIImage(systemName: "arrow.up")!, title: "Send")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let addButton: WalletButton = {
        let button = WalletButton(image: UIImage(systemName: "plus")!, title: "Add")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let receiveButton: WalletButton = {
        let button = WalletButton(image: UIImage(systemName: "arrow.down")!, title: "Receive")
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
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: Constants.sizeButton),
            sendButton.heightAnchor.constraint(equalToConstant: Constants.sizeButton),
            addButton.widthAnchor.constraint(equalToConstant: Constants.sizeButton),
            addButton.heightAnchor.constraint(equalToConstant: Constants.sizeButton),
            receiveButton.widthAnchor.constraint(equalToConstant: Constants.sizeButton),
            receiveButton.heightAnchor.constraint(equalToConstant: Constants.sizeButton)
        ])
        stackView.addArrangedSubview(sendButton)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(receiveButton)
        addSubview(stackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private extension WalletButtonsControl {
    enum Constants {
        static let sizeButton: CGFloat = 65
    }
}
