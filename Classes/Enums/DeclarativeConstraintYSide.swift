import UIKit

public enum DeclarativeConstraintYSide: Int {
    case top, bottom, centerY
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .centerY: return .centerY
        }
    }
}
