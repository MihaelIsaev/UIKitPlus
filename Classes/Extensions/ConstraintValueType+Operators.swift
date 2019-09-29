import Foundation
import UIKit

prefix operator >=
public prefix func >=(rhs: CGFloat) -> ConstraintValueType {
    return .init(.greaterThanOrEqual, rhs)
}

prefix operator <=
public prefix func <=(rhs: CGFloat) -> ConstraintValueType {
    return .init(.lessThanOrEqual, rhs)
}

/// Operator for constraint + multiplier
/// Example:
/// ```swift
///view.left(to: view2, 350 ~ 1.5)
///```
/// `350 ~ 1.5` above means: 350pt with 1.5 multiplier
infix operator ~ : AdditionPrecedence
public func ~(lhs: ConstraintValue, rhs: CGFloat) -> ConstraintValue {
    return ConstraintValueType(lhs.constraintValue.relation, lhs.constraintValue.value, rhs, lhs.constraintValue.priority)
}


/// Operator for constraint + layout-priority
/// Example:
/// ```swift
///view.left(to: view2, 350 ! 999)
///```
/// `350 ! 999` above means: 350pt with 999 priority
infix operator ! : AdditionPrecedence
public func !(lhs: ConstraintValue, rhs: UILayoutPriority) -> ConstraintValue {
    return ConstraintValueType(lhs.constraintValue.relation, lhs.constraintValue.value, lhs.constraintValue.multiplier, rhs)
}

public func !(lhs: ConstraintValue, rhs: Float) -> ConstraintValue {
    return ConstraintValueType(lhs.constraintValue.relation, lhs.constraintValue.value, lhs.constraintValue.multiplier, .init(rhs))
}
