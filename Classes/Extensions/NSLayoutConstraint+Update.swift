import UIKit

extension NSLayoutConstraint {
    @discardableResult
    func update(_ value: ConstraintValue) -> NSLayoutConstraint {
        constant = value.constraintValue.value
        priority = value.constraintValue.priority
        return self
    }
}
