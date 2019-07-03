import UIKit

class DeclarativePreConstraints {
    // Relative
    class Constraint {
        class YSideView {
            let view: UIView
            let side: DeclarativeConstraintYSide
            init (view: UIView, side: DeclarativeConstraintYSide) {
                self.view = view
                self.side = side
            }
        }
        class XSideView {
            let view: UIView
            let side: DeclarativeConstraintXSide
            init (view: UIView, side: DeclarativeConstraintXSide) {
                self.view = view
                self.side = side
            }
        }
        class DSideView {
            let view: UIView
            let side: DeclarativeConstraintDSide
            init (view: UIView, side: DeclarativeConstraintDSide) {
                self.view = view
                self.side = side
            }
        }
        let value: ConstraintValueType
        let ySide: YSideView?
        let xSide: XSideView?
        let dSide: DSideView?
        
        init (value: ConstraintValueType, ySide: YSideView? = nil, xSide: XSideView? = nil, dSide: DSideView? = nil) {
            self.value = value
            self.ySide = ySide
            self.xSide = xSide
            self.dSide = dSide
        }
        
        init (_ mode: NSLayoutConstraint.Relation = .equal, value: CGFloat, multiplier: CGFloat = 1, priority: UILayoutPriority = .init(1000)) {
            self.value = .init(mode, value, multiplier, priority)
            self.ySide = nil
            self.xSide = nil
            self.dSide = nil
        }
        
        convenience init (value: ConstraintValue) {
            self.init(value.constraintValue.relation, value: value.constraintValue.value, multiplier: value.constraintValue.multiplier, priority: value.constraintValue.priority)
        }
    }
    // Itself
    var solo: [NSLayoutConstraint.Attribute: Constraint] = [:]
    // Relative
    var relative: [NSLayoutConstraint.Attribute: Constraint] = [:]
    // SuperView
    var `super`: [NSLayoutConstraint.Attribute: Constraint] = [:]
    // Margin
    var margin: [NSLayoutConstraint.Attribute: CGFloat] = [:]
}
