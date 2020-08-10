#if os(macOS)
import AppKit

public func /(lhs: NSColor, rhs: NSColor) -> NSColor {
    // TODO: implement dynamic color
//    if #available(macOS 10.15, *) {
//        return NSColor { $0.userInterfaceStyle == .dark ? rhs : lhs }
//    } else {
        return lhs
//    }
}
#else
import UIKit

public func /(lhs: UIColor, rhs: UIColor) -> UIColor {
    if #available(iOS 13.0, *) {
        return UIColor { $0.userInterfaceStyle == .dark ? rhs : lhs }
    } else {
        return lhs
    }
}
#endif
