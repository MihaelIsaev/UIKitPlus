import UIKit

class DeclarativePreConstraints {
    // Relative
    class Constraint {
        let value: ConstraintValueType
        let yAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?
        let xAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?
        let dimension: NSLayoutAnchor<NSLayoutDimension>?
        
        init (value: ConstraintValueType, yAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, xAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, dimension: NSLayoutAnchor<NSLayoutDimension>? = nil) {
            self.value = value
            self.yAnchor = yAnchor
            self.xAnchor = xAnchor
            self.dimension = dimension
        }
        
        init (_ mode: NSLayoutConstraint.Relation = .equal, value: CGFloat, multiplier: CGFloat = 1, priority: UILayoutPriority = .init(1000)) {
            self.value = .init(mode, value, multiplier, priority)
            self.yAnchor = nil
            self.xAnchor = nil
            self.dimension = nil
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
