import UIKit

public func /(lhs: UIColor, rhs: UIColor) -> UIColor {
    if #available(iOS 13.0, *) {
        return UIColor { $0.userInterfaceStyle == .dark ? rhs : lhs }
    } else {
        return lhs
    }
}
