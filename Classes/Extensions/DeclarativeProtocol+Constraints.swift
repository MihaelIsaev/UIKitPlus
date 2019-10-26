import UIKit

extension DeclarativeProtocol {
    // MARK: - Edges
    
    // TODO: remove?
//    @discardableResult
//    public func edge(_ side: DeclarativeConstraintCSide, toSuperview: UIView, _ toSide: DeclarativeConstraintCSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
//        _edgeSuperview(anySide: .c(side), to: toSuperview, toAnySide: .c(toSide), value)
//    }
//
//    @discardableResult
//    public func edge(_ side: DeclarativeConstraintDSide, toSuperview: UIView, _ toSide: DeclarativeConstraintDSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
//        _edgeSuperview(anySide: .d(side), to: toSuperview, toAnySide: .d(toSide), value)
//    }
//
//    @discardableResult
//    public func edge(_ side: DeclarativeConstraintXSide, toSuperview: UIView, _ toSide: DeclarativeConstraintXSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
//        _edgeSuperview(anySide: .x(side), to: toSuperview, toAnySide: .x(toSide), value)
//    }
//
//    @discardableResult
//    public func edge(_ side: DeclarativeConstraintYSide, toSuperview: UIView, _ toSide: DeclarativeConstraintYSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
//        _edgeSuperview(anySide: .y(side), to: toSuperview, toAnySide: .y(toSide), value)
//    }
    
    // MARK:
    
    func _relativePreActivate(anySide: DeclarativeConstraintAnySide, to view: UIView, toAnySide: DeclarativeConstraintAnySide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let attribute1 = anySide.attribute
        let attribute2 = toAnySide.attribute
        let preConstraint = PreConstraint(attribute1: attribute1,
                                                         attribute2: attribute2,
                                                         value: value.constraintValue).setSide(with: anySide, to: view, toAnySide: toAnySide)
        return preActivateRelative(preConstraint, side1: attribute1, side2: attribute2, view: view)
    }
    
    @discardableResult
    func preActivateRelative(_ preConstraint: PreConstraint, side1: NSLayoutConstraint.Attribute, side2: NSLayoutConstraint.Attribute, view: UIView) -> Self {
        declarativeView.activateRelative(side1, to: view, side: side2, preConstraint: preConstraint)
        return self
    }
    
    // MARK: - Links to constraints
    
    public var declarativeConstraints: DeclarativeViewConstraints {
        .init(_declarativeView, declarativeView)
    }
    
    public var outer: OuterConstraintValues { .init(declarativeView, _declarativeView._properties.constraintsOuter) }
    
    // MARK: - Cleanup
    
    /// Allows to rebuild all constraints from scratch
    /// by deactivating all existing constraints
    /// and removing them from `preConstraints` dictionary
    @discardableResult
    public func deactivateAndRemoveAllConstraints() -> Self {
        _declarativeView._properties.constraintsMain.forEach { key, value in
            value.isActive = false
        }
        _declarativeView._properties.constraintsMain.removeAll()
        _declarativeView._properties.constraintsOuter.forEach { obj in
            obj.value.forEach { key, value in
                value.isActive = false
            }
        }
        _declarativeView._properties.constraintsOuter.removeAll()
        _declarativeView._properties.preConstraints.relative.removeAll()
        _declarativeView._properties.preConstraints.solo.removeAll()
        _declarativeView._properties.preConstraints.super.removeAll()
        return self
    }
}
