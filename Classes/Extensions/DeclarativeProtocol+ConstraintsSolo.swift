import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func size(_ w: ConstraintValue, _ h: ConstraintValue) -> Self {
        width(w)
        height(h)
        return self
    }
    
    @discardableResult
    public func size(_ value: ConstraintValue) -> Self {
        width(value)
        height(value)
        return self
    }
    
    @discardableResult
    public func width(_ value: ConstraintValue) -> Self {
        let preConstraint = PreConstraint(attribute1: .width, attribute2: nil, value: value.constraintValue)
        _declarativeView._properties.preConstraints.solo[.width] = preConstraint
        declarativeView.activateSolo(preConstraint: preConstraint, side: .width)
        return self
    }
    
    @discardableResult
    public func height(_ value: ConstraintValue) -> Self {
        let preConstraint = PreConstraint(attribute1: .height, attribute2: nil, value: value.constraintValue)
        _declarativeView._properties.preConstraints.solo[.height] = preConstraint
        declarativeView.activateSolo(preConstraint: preConstraint, side: .height)
        return self
    }
    
    @discardableResult
    public func aspectRatio(_ value: ConstraintValue = 1) -> Self {
        dimension(.width, to: declarativeView, .height, value)
    }
    
    @discardableResult
    public func aspectRatio(value: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .defaultHigh) -> Self {
        dimension(.width, to: declarativeView, .height, ConstraintValueType(.equal, value, multiplier, priority))
    }
}
