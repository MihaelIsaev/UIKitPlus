import UIKit

public enum DeclarativeConstraintXSide: Int {
    case leading, leadingMargin, trailing, trailingMargin, centerX, centerXMargin
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .leading: return .leading
        case .leadingMargin: return .leadingMargin
        case .trailing: return .trailing
        case .trailingMargin: return .trailingMargin
        case .centerX: return .centerX
        case .centerXMargin: return .centerXWithinMargins
        }
    }
}
