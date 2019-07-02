import Foundation
import UIKit

public struct ConstraintValueType: ConstraintValue {
    public var constraintValue: ConstraintValueType { return self }
    
    let relation: NSLayoutConstraint.Relation
    let value: CGFloat
    let multiplier: CGFloat
    let priority: UILayoutPriority
    
    init (_ mode: NSLayoutConstraint.Relation = .equal, _ value: CGFloat, _ multiplier: CGFloat = 1, _ priority: UILayoutPriority = .init(1000)) {
        self.relation = mode
        self.value = value
        self.multiplier = multiplier
        self.priority = priority
    }
}
