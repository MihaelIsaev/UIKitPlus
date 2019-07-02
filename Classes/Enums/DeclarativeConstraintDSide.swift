import UIKit

public enum DeclarativeConstraintDSide: Int {
    case width, height
    var side: NSLayoutConstraint.Attribute {
        switch self {
        case .width: return .width
        case .height: return .height
        }
    }
}
