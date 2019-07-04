import UIKit

public enum DeclarativeConstraintXSide: Int {
    case leading, leadingMargin, trailing, trailingMargin
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .leading: return .leading
        case .leadingMargin: return .leadingMargin
        case .trailing: return .trailing
        case .trailingMargin: return .trailingMargin
        }
    }
}
