import UIKit

enum DeclarativeConstraintAnySide {
    case c(DeclarativeConstraintCSide)
    case d(DeclarativeConstraintDSide)
    case x(DeclarativeConstraintXSide)
    case y(DeclarativeConstraintYSide)
    
    var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .c(let side): return side.side
        case .d(let side): return side.side
        case .x(let side): return side.side
        case .y(let side): return side.side
        }
    }
}
