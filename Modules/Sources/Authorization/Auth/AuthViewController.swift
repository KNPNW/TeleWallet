import UIKit
import Theme

public class AuthViewController: UIViewController {

    public var completionHandler: ((String) -> Void)?

    private lazy var authView: AuthView = {
        let view = AuthView()
        view.completionHandler = { [weak self] value in
            self?.completionHandler?(value)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.Colors.background
        view.addSubview(authView)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            authView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            authView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
