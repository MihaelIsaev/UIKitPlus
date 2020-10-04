import UIKit

public func /(lhs: UIColor, rhs: UIColor) -> UIColor {
    if #available(iOS 13.0, *) {
        return UIColor { $0.userInterfaceStyle == .dark ? rhs : lhs }
    } else {
        return lhs
    }
}

public func /(lhs: CGColor, rhs: CGColor) -> CGColor {
    if #available(iOS 13.0, *) {
        //let isDark =  UIScreen.main.traitCollection.userInterfaceStyle == .dark
        //return isDark ? rhs : lhs
        return UIScreen.main.traitCollection.userInterfaceStyle == .dark ? rhs : lhs
    } else {
        return lhs
    }
}
