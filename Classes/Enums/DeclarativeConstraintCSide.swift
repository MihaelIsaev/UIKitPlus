import UIKit

public enum DeclarativeConstraintCSide: Int {
    case x, xWithinMargins, y, yWithinMargins
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .x: return .centerX
        case .xWithinMargins: return .centerXWithinMargins
        case .y: return .centerY
        case .yWithinMargins: return .centerYWithinMargins
        }
    }
}
