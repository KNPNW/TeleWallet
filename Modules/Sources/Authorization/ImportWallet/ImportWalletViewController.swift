import UIKit
import Theme
import MnemonicGenerator

public class ImportWalletViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var importView: ImportView = {
        let view = ImportView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.Colors.background

        setupUI()
        setupLayout()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(importView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            importView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            importView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 20),
            importView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -20),
            importView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

}
