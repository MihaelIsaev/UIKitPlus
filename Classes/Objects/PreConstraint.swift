import UIKit

class PreConstraint {
    let value: ConstraintValueType
    let attribute1: NSLayoutConstraint.Attribute
    let attribute2: NSLayoutConstraint.Attribute?
    
    var anySide: AnySideView?
    
    var sideView: SideViewProtocol? {
        guard let anySide = anySide else { return nil }
        switch attribute1 {
        case .top, .topMargin, .bottom, .bottomMargin:
            switch anySide {
            case .y(let view): return view
            default: return nil
            }
        case .leading, .leadingMargin, .trailing, .trailingMargin:
            switch anySide {
            case .x(let view): return view
            default: return nil
            }
        case .centerX, .centerXWithinMargins, .centerY, .centerYWithinMargins:
            switch anySide {
            case .c(let view): return view
            default: return nil
            }
        case .width, .height:
            switch anySide {
            case .d(let view): return view
            default: return nil
            }
        default: return nil
        }
    }
    
    @discardableResult
    func setSide(with anySide: DeclarativeConstraintAnySide, to view: UIView, toAnySide: DeclarativeConstraintAnySide) -> PreConstraint {
        switch anySide {
        case .c:
            switch toAnySide {
            case .c(let side2):
                self.anySide = .c(.init(view: view, side: side2))
                break
            default: break
            }
        case .d:
            switch toAnySide {
            case .d(let side2):
                self.anySide = .d(.init(view: view, side: side2))
            default: break
            }
        case .x:
            switch toAnySide {
            case .x(let side2):
                self.anySide = .x(.init(view: view, side: side2))
            default: break
            }
        case .y:
            switch toAnySide {
            case .y(let side2):
                self.anySide = .y(.init(view: view, side: side2))
            default: break
            }
        }
        return self
    }
    
    init (value: ConstraintValueType,
           attribute1: NSLayoutConstraint.Attribute,
           attribute2: NSLayoutConstraint.Attribute?) {
        self.value = value
        self.attribute1 = attribute1
        self.attribute2 = attribute2
    }
    
    init (_ mode: NSLayoutConstraint.Relation = .equal,
          attribute1: NSLayoutConstraint.Attribute,
          attribute2: NSLayoutConstraint.Attribute?,
          value: CGFloat,
          multiplier: CGFloat = 1,
          priority: UILayoutPriority = .init(1000)) {
        self.value = .init(mode, value, multiplier, priority)
        self.attribute1 = attribute1
        self.attribute2 = attribute2
    }
    
    convenience init (attribute1: NSLayoutConstraint.Attribute,
                             attribute2: NSLayoutConstraint.Attribute?,
                             value: ConstraintValue) {
        self.init(value.constraintValue.relation,
                   attribute1: attribute1,
                   attribute2: attribute2,
                   value: value.constraintValue.value,
                   multiplier: value.constraintValue.multiplier,
                   priority: value.constraintValue.priority)
    }
}

extension PreConstraint {
    enum AnySideView {
        case c(CSideView)
        case d(DSideView)
        case x(XSideView)
        case y(YSideView)
    }
    class CSideView: SideViewProtocol {
        let view: UIView
        let side: DeclarativeConstraintCSide
        init (view: UIView, side: DeclarativeConstraintCSide) {
            self.view = view
            self.side = side
        }
    }
    class DSideView: SideViewProtocol {
        let view: UIView
        let side: DeclarativeConstraintDSide
        init (view: UIView, side: DeclarativeConstraintDSide) {
            self.view = view
            self.side = side
        }
    }
    class XSideView: SideViewProtocol {
        let view: UIView
        let side: DeclarativeConstraintXSide
        init (view: UIView, side: DeclarativeConstraintXSide) {
            self.view = view
            self.side = side
        }
    }
    class YSideView: SideViewProtocol {
        let view: UIView
        let side: DeclarativeConstraintYSide
        init (view: UIView, side: DeclarativeConstraintYSide) {
            self.view = view
            self.side = side
        }
    }
}
