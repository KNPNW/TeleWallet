import UIKit
import Combine
import Theme

class PasswordIndicator: UIView {

    private var circles: [UIImageView] = []

    @Published
    var animation = false

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        drawCircles()
        setupStack()
        addSubview(stack)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupStack() {
        for index in 0..<circles.count {
            stack.addArrangedSubview(circles[index])
        }
    }

    private func drawCircles() {
        for _ in 0..<4 {
            let circule: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: "circle")
                imageView.tintColor = Theme.Colors.purple
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            NSLayoutConstraint.activate([
                circule.heightAnchor.constraint(equalToConstant: Theme.Sizes.indicator),
                circule.widthAnchor.constraint(equalToConstant: Theme.Sizes.indicator)
            ])
            circles.append(circule)
        }
    }

    func fillIndicator(num: Int) {
        circles[num].image = UIImage(systemName: "circle.fill")
    }

    func unFillIndicator(num: Int) {
        circles[num].image = UIImage(systemName: "circle")
    }

    func cleanIndicator() {
        for circle in circles {
            circle.image = UIImage(systemName: "circle")
        }
    }

    func errorAnimation() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseIn],
            animations: {
                self.animation = true
                self.circles.forEach { circle in
                    circle.tintColor = Theme.Colors.error
                    self.stack.spacing = 20
                    circle.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
            }, completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.circles.forEach { circle in
                            circle.image = UIImage(systemName: "circle")
                            circle.tintColor = Theme.Colors.purple
                            self.stack.spacing = 5
                            circle.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }
                    }) { _ in
                        self.animation = false
                    }
            })
    }
}
