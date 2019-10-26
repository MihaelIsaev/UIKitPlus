import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func deapplyAllConstraints() -> Self {
        // Solo
        _declarativeView._properties.appliedPreConstraintsSolo.forEach { $0.constraint?.isActive = false }
        _declarativeView._properties.notAppliedPreConstraintsSolo.append(contentsOf: _declarativeView._properties.appliedPreConstraintsSolo)
        _declarativeView._properties.appliedPreConstraintsSolo.removeAll()
        // Super
        _declarativeView._properties.appliedPreConstraintsSuper.forEach { $0.constraint?.isActive = false }
        _declarativeView._properties.notAppliedPreConstraintsSuper.append(contentsOf: _declarativeView._properties.appliedPreConstraintsSuper)
        _declarativeView._properties.appliedPreConstraintsSuper.removeAll()
        // Relative
        _declarativeView._properties.appliedPreConstraintsRelative.forEach { $0.constraint?.isActive = false }
        _declarativeView._properties.notAppliedPreConstraintsRelative.append(contentsOf: _declarativeView._properties.appliedPreConstraintsRelative)
        _declarativeView._properties.appliedPreConstraintsRelative.removeAll()
        return self
    }
}
