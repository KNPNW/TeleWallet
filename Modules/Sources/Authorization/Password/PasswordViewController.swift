import UIKit
import Theme

public class PasswordViewController: UIViewController {

    public var complitionHandler: ((String) -> Void)?

    private lazy var passwordView: PasswordView = {
        let view = PasswordView()
        view.fullPasswordHandler = { [weak self] password in
            self?.complitionHandler?(password)

        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.Colors.background
        setupUI()
        setupLayout()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        passwordView.clean()
    }

    private func setupUI() {
        view.addSubview(passwordView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    public func setupPasswordView(title: String) {
        passwordView.setup(title: title)
    }

    public func errorPassword() {
        passwordView.showError()
    }
}
