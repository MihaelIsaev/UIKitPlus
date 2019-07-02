import UIKit

public enum DeclarativeConstraintXSide: Int {
    case leading, trailing, centerX
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .leading: return .leading
        case .trailing: return .trailing
        case .centerX: return .centerX
        }
    }
}
