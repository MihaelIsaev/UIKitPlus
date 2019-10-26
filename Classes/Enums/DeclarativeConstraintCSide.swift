import UIKit

public enum DeclarativeConstraintCXSide: Int {
    case x, xMargin
    case leading, leadingMargin, left, leftMargin
    case trailing, trailingMargin, right, rightMargin
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .x: return .centerX
        case .xMargin: return .centerXWithinMargins
        case .leading: return .leading
        case .leadingMargin: return .leadingMargin
        case .left: return .left
        case .leftMargin: return .leftMargin
        case .trailing: return .trailing
        case .trailingMargin: return .trailingMargin
        case .right: return .right
        case .rightMargin: return .rightMargin
        }
    }
}

public enum DeclarativeConstraintCYSide: Int {
    case y, yMargin
    case top, topMargin, bottom, bottomMargin
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .y: return .centerY
        case .yMargin: return .centerYWithinMargins
        case .top: return .top
        case .topMargin: return .topMargin
        case .bottom: return .bottom
        case .bottomMargin: return .bottomMargin
        }
    }
}
