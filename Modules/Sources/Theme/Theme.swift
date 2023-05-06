import UIKit

public enum Theme {
    public enum Colors {
        public static let background = UIColor(named: "background")!
        public static let text = UIColor(named: "text")!
        public static let error = UIColor.red
        public static let black = UIColor.black
        public static let purple = UIColor(named: "teleWalletPurple")!
        public static let lightPurple = UIColor(named: "lightPurple")!
    }

    public enum Fonts {
        public static let title = UIFont.boldSystemFont(ofSize: 38)
        public static let authButton = UIFont.boldSystemFont(ofSize: 20)
        public static let walletButton = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        public static let keybordButton = UIFont.boldSystemFont(ofSize: 30)
    }

    public enum Sizes {
        public static let keybordButton: CGFloat = 80
        public static let indicator: CGFloat = 20
    }

    public enum StyleElements {
        public static let buttonCornerRadius: CGFloat = 20
    }
}
