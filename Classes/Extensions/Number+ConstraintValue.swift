import Foundation

extension Int: ConstraintValue {
    public var constraintValue: ConstraintValueType {
        return .init(.equal, CGFloat(self))
    }
}

extension Double: ConstraintValue {
    public var constraintValue: ConstraintValueType {
        return .init(.equal, CGFloat(self))
    }
}

extension CGFloat: ConstraintValue {
    public var constraintValue: ConstraintValueType {
        return .init(.equal, self)
    }
}
