import UIKit

extension DeclarativeProtocol {
    // MARK: - Size
    
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
    public func equalSize(to: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        dimension(.width, to: to, .width, value)
        dimension(.height, to: to, .height, value)
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
    
    private func _relativePreActivate(anySide: DeclarativeConstraintAnySide, to view: UIView, toAnySide: DeclarativeConstraintAnySide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let attribute1 = anySide.attribute
        let attribute2 = toAnySide.attribute
        let preConstraint = PreConstraint(attribute1: attribute1,
                                                         attribute2: attribute2,
                                                         value: value.constraintValue).setSide(with: anySide, to: view, toAnySide: toAnySide)
        return preActivateRelative(preConstraint, side1: attribute1, side2: attribute2, view: view)
    }
    
    @discardableResult
    public func spacing(_ side: DeclarativeConstraintXSide, to view: UIView, _ toSide: DeclarativeConstraintXSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        _relativePreActivate(anySide: .x(side), to: view, toAnySide: .x(toSide), value)
    }
    
    @discardableResult
    public func spacing(_ side: DeclarativeConstraintYSide, to view: UIView, _ toSide: DeclarativeConstraintYSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        _relativePreActivate(anySide: .y(side), to: view, toAnySide: .y(toSide), value)
    }
    
    @discardableResult
    public func center(_ side: DeclarativeConstraintCSide, to view: UIView, _ toSide: DeclarativeConstraintCSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        _relativePreActivate(anySide: .c(side), to: view, toAnySide: .c(toSide), value)
    }
    
    @discardableResult
    public func dimension(_ side: DeclarativeConstraintDSide, to view: UIView, _ toSide: DeclarativeConstraintDSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        _relativePreActivate(anySide: .d(side), to: view, toAnySide: .d(toSide), value)
    }
    
    @discardableResult
    private func preActivateRelative(_ preConstraint: PreConstraint, side1: NSLayoutConstraint.Attribute, side2: NSLayoutConstraint.Attribute, view: UIView) -> Self {
        declarativeView.activateRelative(side1, to: view, side: side2, preConstraint: preConstraint)
        return self
    }
    
    // MARK: - Relative
    
    /// By default to `bottom` of destination view
    @discardableResult
    public func top(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.top, to: view, .bottom, value)
    }
    
    @discardableResult
    public func top(to side: DeclarativeConstraintYSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.top, to: view, side, value)
    }
    
    /// By default to `trailing` of destination view
    @discardableResult
    public func leading(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.leading, to: view, .trailing, value)
    }
    
    @discardableResult
    public func leading(to side: DeclarativeConstraintXSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.leading, to: view, side, value)
    }
    
    /// By default to `leading` of destination view
    @discardableResult
    public func trailing(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.trailing, to: view, .leading, value)
    }
    
    @discardableResult
    public func trailing(to side: DeclarativeConstraintXSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.trailing, to: view, side, value)
    }
    
    /// By default to `top` of destination view
    @discardableResult
    public func bottom(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.bottom, to: view, .top, value)
    }
    
    @discardableResult
    public func bottom(to side: DeclarativeConstraintYSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        spacing(.bottom, to: view, side, value)
    }
    
    @discardableResult
    public func centerX(to side: DeclarativeConstraintCSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        center(.x, to: view, side, value)
    }
    
    /// By default to `centerX` of destination view
    @discardableResult
    public func centerX(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        center(.x, to: view, .x, value)
    }
    
    @discardableResult
    public func centerY(to side: DeclarativeConstraintCSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        center(.y, to: view, side, value)
    }
    
    /// By default to `centerН` of destination view
    @discardableResult
    public func centerY(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        center(.y, to: view, .y, value)
    }
    
    /// By default to `width` of destination view
    @discardableResult
    public func width(to view: UIView, _ relation: NSLayoutConstraint.Relation = .equal, multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        dimension(.width, to: view, .width, ConstraintValueType(relation, 0, multipliedBy, priority))
    }
    
    @discardableResult
    public func width(to side: DeclarativeConstraintDSide, of view: UIView, _ relation: NSLayoutConstraint.Relation = .equal, multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        dimension(.width, to: view, side, ConstraintValueType(relation, 0, multipliedBy, priority))
    }
    
    /// By default to `height` of destination view
    @discardableResult
    public func height(to view: UIView, _ relation: NSLayoutConstraint.Relation = .equal, multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        dimension(.height, to: view, .height, ConstraintValueType(relation, 0, multipliedBy, priority))
    }
    
    @discardableResult
    public func height(to side: DeclarativeConstraintDSide, of view: UIView, _ relation: NSLayoutConstraint.Relation = .equal, multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        dimension(.height, to: view, side, ConstraintValueType(relation, 0, multipliedBy, priority))
    }
    
    // MARK: - Center
    
    @discardableResult
    public func centerInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        centerXInSuperview(value)
        centerYInSuperview(value)
        return self
    }
    
    @discardableResult
    public func centerInSuperview(x: ConstraintValue = CGFloat(0), y: ConstraintValue = CGFloat(0)) -> Self {
        centerXInSuperview(x)
        centerYInSuperview(y)
        return self
    }
    
    @discardableResult
    public func center(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        center(.x, to: view,  .x, value)
        center(.y, to: view, .y, value)
        return self
    }
    
    @discardableResult
    public func center(to view: UIView, x: ConstraintValue = CGFloat(0), y: ConstraintValue = CGFloat(0)) -> Self {
        center(.x, to: view, .x, x)
        center(.y, to: view, .y, y)
        return self
    }
    
    // MARK: - Links to constraints
    
    public var declarativeConstraints: DeclarativeViewConstraints {
        .init(_declarativeView, declarativeView)
    }
    
    public var height: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.height]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .height) }
    }
    
    public var width: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.width]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .width) }
    }
    
    public var top: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.top]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .top) }
    }
    
    public var leading: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.leading]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .leading) }
    }
    
    public var trailing: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.trailing]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .trailing) }
    }
    
    public var bottom: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.bottom]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .bottom) }
    }
    
    public var centerX: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.centerX]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .centerX) }
    }
    
    public var centerY: CGFloat? {
        get { _declarativeView._properties.constraintsMain[.centerY]?.constant }
        set { _declarativeView._properties.constraintsMain.setValue(newValue, for: .centerY) }
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

extension UIView {
    // MARK: - Activation
    
    func activateSolo(preConstraint: PreConstraint, side: NSLayoutConstraint.Attribute) {
        guard let self = self as? DeclarativeProtocolInternal else { return }
        let constant = preConstraint.value.value
        var constraint: NSLayoutConstraint?
        switch side {
        case .width, .height:
            constraint = .init(item: self,
                               attribute: side,
                               relatedBy: preConstraint.value.relation,
                               toItem: nil,
                               attribute: side,
                               multiplier: preConstraint.value.multiplier,
                               constant: constant)
        default: return
        }
        if let constraint = constraint {
            if let _ = self._properties.constraintsMain[side] {
                self._properties.constraintsMain.setValue(constraint.constant, for: side)
            } else {
                self._properties.constraintsMain[side] = constraint.update(preConstraint.value).activated()
            }
        }
    }
    
    @discardableResult
    func activateRelative(_ side: NSLayoutConstraint.Attribute, to: UIView, side toSide: NSLayoutConstraint.Attribute, preConstraint: PreConstraint, second: Bool = false) -> Self {
        guard let s = self as? DeclarativeProtocolInternal else { return self }
        s._properties.constraintsOuter.removeValue(forKey: side, andView: to)
        s._properties.preConstraints.relative.setValue(side: side, value: preConstraint.value, forKey: toSide, andView: to)
        let constant = preConstraint.value.value
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: side,
                                            relatedBy: preConstraint.value.relation,
                                            toItem: to,
                                            attribute: toSide,
                                            multiplier: preConstraint.value.multiplier,
                                            constant: constant)
        s._properties.constraintsOuter.setValue(constraint, forKey: side, andView: to)
        if !second, to.superview == nil, let _ = to as? DeclarativeProtocolInternal { // rethink this tricky logic
            to.activateRelative(toSide, to: self, side: side, preConstraint: preConstraint, second: true)
        }
        let isDescant = isDescendant(of: to.superview ?? UIView()) || to.isDescendant(of: superview ?? UIView())
        if (superview != nil && to.superview != nil && isDescant) || superview == to || to.superview == self {
            constraint.isActive = true
        }
        return self
    }
}
