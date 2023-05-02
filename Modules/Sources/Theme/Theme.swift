import UIKit

public enum Theme {
    public enum Colors {
        public static let background = UIColor.white
        public static let black = UIColor.black
        public static let purple = UIColor(named: "teleWalletPurple")!
    }

    public enum Fonts {
        public static let balance = UIFont.boldSystemFont(ofSize: 35)
        public static let authButton = UIFont.boldSystemFont(ofSize: 20)
        public static let walletButton = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    }
}
