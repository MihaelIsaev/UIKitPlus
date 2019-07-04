import UIKit

public enum DeclarativeConstraintYSide: Int {
    case top, topMargin, bottom, bottomMargin
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .top: return .top
        case .topMargin: return .topMargin
        case .bottom: return .bottom
        case .bottomMargin: return .bottomMargin
        }
    }
}
