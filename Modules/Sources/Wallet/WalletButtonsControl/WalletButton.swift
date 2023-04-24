//
//  WalletButton.swift
//  
//
//  Created by Кирилл Падалица on 24.04.2023.
//

import UIKit

class WalletButton: UIView {

    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        backgroundColor = Constants.backgroundColor
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

        addSubview(self.image)
        addSubview(label)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            image.widthAnchor.constraint(equalToConstant: Constants.sizeImage),
            image.heightAnchor.constraint(equalToConstant: Constants.sizeImage),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}

private extension WalletButton {
    enum Constants {
        static let backgroundColor: UIColor = .white
        static let sizeImage: CGFloat = 20
        static let cornerRadius: CGFloat = 15
    }
}
