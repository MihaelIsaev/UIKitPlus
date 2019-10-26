import Foundation
import UIKit

extension Int: ConstraintValue {
    public var constraintValue: ConstraintValueType {
        .init(.equal, CGFloat(self))
    }
}

extension Double: ConstraintValue {
    public var constraintValue: ConstraintValueType {
        .init(.equal, CGFloat(self))
    }
}

extension CGFloat: ConstraintValue {
    public var constraintValue: ConstraintValueType {
        .init(.equal, self)
    }
}
