import UIKit
import Theme

public class CreateViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var createView: CreateView = {
        let view = CreateView()
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
        scrollView.addSubview(createView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            createView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            createView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 20),
            createView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -20),
            createView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    public func insertPhase(phase: [String]) {
        createView.mnemonicField.insertMnemonicPhase(phase: phase)
    }

}
