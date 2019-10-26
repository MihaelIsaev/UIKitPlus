import UIKit

public enum DeclarativeConstraintXSide: Int {
    case leading, leadingMargin, left, leftMargin, trailing, trailingMargin, right, rightMargin, centerX, centerXMargin
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .leading: return .leading
        case .leadingMargin: return .leadingMargin
        case .left: return .left
        case .leftMargin: return .leftMargin
        case .trailing: return .trailing
        case .trailingMargin: return .trailingMargin
        case .right: return .right
        case .rightMargin: return .rightMargin
        case .centerX: return .centerX
        case .centerXMargin: return .centerXWithinMargins
        }
    }
}
