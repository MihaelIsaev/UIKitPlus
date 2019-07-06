import UIKit

extension DeclarativeProtocol {
    // MARK: - Size
    
    @discardableResult
    public func size(_ w: ConstraintValue, _ h: ConstraintValue) -> Self {
        width(w)
        height(h)
        return self
    }
    
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
        _declarativeView._preConstraints.solo[.width] = preConstraint
        activateSolo(preConstraint: preConstraint, side: .width)
        return self
    }
    
    @discardableResult
    public func height(_ value: ConstraintValue) -> Self {
        let preConstraint = PreConstraint(attribute1: .height, attribute2: nil, value: value.constraintValue)
        _declarativeView._preConstraints.solo[.height] = preConstraint
        activateSolo(preConstraint: preConstraint, side: .height)
        return self
    }
    
    // MARK: - Edges
    
    private func _edgeSuperview(anySide: DeclarativeConstraintAnySide, to view: UIView?, toAnySide: DeclarativeConstraintAnySide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = PreConstraint(attribute1: anySide.attribute,
                                                         attribute2: toAnySide.attribute,
                                                         value: value.constraintValue)
        if let view = view {
            preConstraint.setSide(with: anySide, to: view, toAnySide: toAnySide)
            if let _ = declarativeView.superview {
                activateSuper(anySide.attribute, to: view, side: toAnySide.attribute, preConstraint: preConstraint)
            }
        }
        _declarativeView._preConstraints.super[anySide.attribute] = preConstraint
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintCSide, toSuperview: UIView, _ toSide: DeclarativeConstraintCSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .c(side), to: toSuperview, toAnySide: .c(toSide), value)
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintDSide, toSuperview: UIView, _ toSide: DeclarativeConstraintDSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .d(side), to: toSuperview, toAnySide: .d(toSide), value)
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintXSide, toSuperview: UIView, _ toSide: DeclarativeConstraintXSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .x(side), to: toSuperview, toAnySide: .x(toSide), value)
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintYSide, toSuperview: UIView, _ toSide: DeclarativeConstraintYSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .y(side), to: toSuperview, toAnySide: .y(toSide), value)
    }
    
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
        return _relativePreActivate(anySide: .x(side), to: view, toAnySide: .x(toSide), value)
    }
    
    @discardableResult
    public func spacing(_ side: DeclarativeConstraintYSide, to view: UIView, _ toSide: DeclarativeConstraintYSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _relativePreActivate(anySide: .y(side), to: view, toAnySide: .y(toSide), value)
    }
    
    @discardableResult
    public func center(_ side: DeclarativeConstraintCSide, to view: UIView, _ toSide: DeclarativeConstraintCSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _relativePreActivate(anySide: .c(side), to: view, toAnySide: .c(toSide), value)
    }
    
    @discardableResult
    public func dimension(_ side: DeclarativeConstraintDSide, to view: UIView, _ toSide: DeclarativeConstraintDSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return _relativePreActivate(anySide: .d(side), to: view, toAnySide: .d(toSide), value)
    }
    
    @discardableResult
    private func preActivateRelative(_ preConstraint: PreConstraint, side1: NSLayoutConstraint.Attribute, side2: NSLayoutConstraint.Attribute, view: UIView) -> Self {
        return activateRelative(side1, to: view, side: side2, preConstraint: preConstraint)
    }
    
    // MARK: - Superview
    
    @discardableResult
    public func edgesToSuperview(_ value: CGFloat = 0) -> Self {
        topToSuperview(value)
        leadingToSuperview(value)
        trailingToSuperview(value * (-1))
        bottomToSuperview(value * (-1))
        return self
    }
    
    @discardableResult
    public func edgesToSuperview(top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) -> Self {
        if let top = top {
            topToSuperview(top)
        }
        if let leading = leading {
            leadingToSuperview(leading)
        }
        if let trailing = trailing {
            trailingToSuperview(trailing)
        }
        if let bottom = bottom {
            bottomToSuperview(bottom)
        }
        return self
    }
    
    @discardableResult
    public func topToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .y(.top), to: declarativeView.superview, toAnySide: .y(.top), value)
    }
    
    @discardableResult
    public func leadingToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .x(.leading), to: nil, toAnySide: .x(.leading), value)
    }
    
    @discardableResult
    public func trailingToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .x(.trailing), to: nil, toAnySide: .x(.trailing), value)
    }
    
    @discardableResult
    public func bottomToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .y(.bottom), to: nil, toAnySide: .y(.bottom), value)
    }
    
    @discardableResult
    public func centerXInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .c(.x), to: nil, toAnySide: .c(.x), value)
    }
    
    @discardableResult
    public func centerYInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        return _edgeSuperview(anySide: .c(.y), to: nil, toAnySide: .c(.y), value)
    }
    
    @discardableResult
    public func widthToSuperview() -> Self {
        return _edgeSuperview(anySide: .d(.width), to: nil, toAnySide: .d(.width))
    }
    
    @discardableResult
    public func heightToSuperview() -> Self {
        return _edgeSuperview(anySide: .d(.height), to: nil, toAnySide: .d(.height))
    }
    
    // MARK: - Relative
    
    @discardableResult
    public func top(to side: DeclarativeConstraintYSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return spacing(.top, to: view, side, value)
    }
    
    @discardableResult
    public func leading(to side: DeclarativeConstraintXSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return spacing(.leading, to: view, side, value)
    }
    
    @discardableResult
    public func trailing(to side: DeclarativeConstraintXSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return spacing(.trailing, to: view, side, value)
    }
    
    @discardableResult
    public func bottom(to side: DeclarativeConstraintYSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return spacing(.bottom, to: view, side, value)
    }
    
    @discardableResult
    public func centerX(to side: DeclarativeConstraintCSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return center(.x, to: view, side, value)
    }
    
    @discardableResult
    public func centerX(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return center(.x, to: view, .x, value)
    }
    
    @discardableResult
    public func centerY(to side: DeclarativeConstraintCSide, of view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return center(.y, to: view, side, value)
    }
    
    @discardableResult
    public func centerY(to view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return center(.y, to: view, .y, value)
    }
    
    @discardableResult
    public func width(to side: DeclarativeConstraintDSide = .width, of view: UIView) -> Self {
        return dimension(.width, to: view, side)
    }
    
    @discardableResult
    public func height(to side: DeclarativeConstraintDSide = .height, of view: UIView) -> Self {
        return dimension(.height, to: view, side)
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
        return .init(_declarativeView, declarativeView)
    }
    
    public var height: CGFloat? {
        get { return _declarativeView._constraintsMain[.height]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .height) }
    }
    
    public var width: CGFloat? {
        get { return _declarativeView._constraintsMain[.width]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .width) }
    }
    
    public var top: CGFloat? {
        get { return _declarativeView._constraintsMain[.top]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .top) }
    }
    
    public var leading: CGFloat? {
        get { return _declarativeView._constraintsMain[.leading]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .leading) }
    }
    
    public var trailing: CGFloat? {
        get { return _declarativeView._constraintsMain[.trailing]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .trailing) }
    }
    
    public var bottom: CGFloat? {
        get { return _declarativeView._constraintsMain[.bottom]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .bottom) }
    }
    
    public var centerX: CGFloat? {
        get { return _declarativeView._constraintsMain[.centerX]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .centerX) }
    }
    
    public var centerY: CGFloat? {
        get { return _declarativeView._constraintsMain[.centerY]?.constant }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .centerY) }
    }
    
    public var outer: OuterConstraintValues { return .init(declarativeView, _declarativeView._constraintsOuter) }
    
    // MARK: - Activation
    
    func activateSolo(preConstraint: PreConstraint, side: NSLayoutConstraint.Attribute) {
        let constant = preConstraint.value.value
        var constraint: NSLayoutConstraint?
        switch side {
        case .width, .height:
            constraint = .init(item: declarativeView,
                               attribute: side,
                               relatedBy: preConstraint.value.relation,
                               toItem: nil,
                               attribute: side,
                               multiplier: preConstraint.value.multiplier,
                               constant: constant)
        default: return
        }
        if let constraint = constraint {
            if let _ = _declarativeView._constraintsMain[side] {
                _declarativeView._constraintsMain.setValue(constraint.constant, for: side)
            } else {
                _declarativeView._constraintsMain[side] = constraint.update(preConstraint.value).activated()
            }
        }
    }
    
    func activateSuper(_ side: NSLayoutConstraint.Attribute, to: UIView, side toSide: NSLayoutConstraint.Attribute, preConstraint: PreConstraint) {
        _declarativeView._constraintsMain.removeValue(for: side)
        _declarativeView._preConstraints.super[side] = preConstraint
        let constant = preConstraint.value.value
        let constraint = NSLayoutConstraint(item: declarativeView,
                                            attribute: side,
                                            relatedBy: preConstraint.value.relation,
                                            toItem: to,
                                            attribute: toSide,
                                            multiplier: preConstraint.value.multiplier,
                                            constant: constant)
        _declarativeView._constraintsMain.setValue(constraint.update(preConstraint.value), for: side)
        if let dest = to as? DeclarativeProtocolInternal {
            dest._preConstraints.relative.setValue(side: side, value: preConstraint.value, forKey: toSide, andView: declarativeView)
            dest._constraintsOuter.setValue(constraint, forKey: toSide, andView: declarativeView)
        }
        if declarativeView.superview != nil && to.superview != nil || declarativeView.superview == to || to.superview == declarativeView {
            constraint.isActive = true
        }
    }
    
    @discardableResult
    func activateRelative(_ side: NSLayoutConstraint.Attribute, to: UIView, side toSide: NSLayoutConstraint.Attribute, preConstraint: PreConstraint) -> Self {
        _declarativeView._constraintsOuter.removeValue(forKey: side, andView: to)
        _declarativeView._preConstraints.relative.setValue(side: side, value: preConstraint.value, forKey: toSide, andView: to)
        let constant = preConstraint.value.value
        let constraint = NSLayoutConstraint(item: declarativeView,
                                                             attribute: side,
                                                             relatedBy: preConstraint.value.relation,
                                                             toItem: to,
                                                             attribute: toSide,
                                                             multiplier: preConstraint.value.multiplier,
                                                             constant: constant)
        _declarativeView._constraintsOuter.setValue(constraint, forKey: side, andView: to)
        if let dest = to as? DeclarativeProtocolInternal {
            dest._preConstraints.relative.setValue(side: side, value: preConstraint.value, forKey: toSide, andView: declarativeView)
            dest._constraintsOuter.setValue(constraint, forKey: toSide, andView: declarativeView)
        }
        if declarativeView.superview != nil && to.superview != nil || declarativeView.superview == to || to.superview == declarativeView {
            constraint.isActive = true
        }
        return self
    }
}
