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
    public func sameSize(as: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        edge(.width, to: `as`, .width, value)
        edge(.height, to: `as`, .height, value)
        return self
    }
    
    @discardableResult
    public func width(_ value: ConstraintValue) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value)
        _declarativeView._preConstraints.solo[.width] = preConstraint
        if let superview = declarativeView.superview {
            activateSolo(superview: superview, preConstraint: preConstraint, side: .width)
        }
        return self
    }
    
    @discardableResult
    public func height(_ value: ConstraintValue) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value)
        _declarativeView._preConstraints.solo[.height] = preConstraint
        if let superview = declarativeView.superview {
            activateSolo(superview: superview, preConstraint: preConstraint, side: .height)
        }
        return self
    }
    
    // MARK: - Edges
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintXSide, toSuperview: UIView, _ toSide: DeclarativeConstraintXSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, xSide: .init(view: toSuperview, side: toSide))
        _declarativeView._preConstraints.super[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(side.side, to: superview, side: side.side, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintYSide, toSuperview: UIView, _ toSide: DeclarativeConstraintYSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, ySide: .init(view: toSuperview, side: toSide))
        _declarativeView._preConstraints.super[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(side.side, to: superview, side: side.side, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintDSide, toSuperview: UIView, _ toSide: DeclarativeConstraintDSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, dSide: .init(view: toSuperview, side: toSide))
        _declarativeView._preConstraints.super[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(side.side, to: superview, side: side.side, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintXSide, to: UIView, _ toSide: DeclarativeConstraintXSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, xSide: .init(view: to, side: toSide))
        _declarativeView._preConstraints.relative[side.side] = preConstraint
        activateRelative(side.side, to: to, side: toSide.side, preConstraint: preConstraint)
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintYSide, to: UIView, _ toSide: DeclarativeConstraintYSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, ySide: .init(view: to, side: toSide))
        _declarativeView._preConstraints.relative[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(side.side, to: to, side: toSide.side, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintDSide, to: UIView, _ toSide: DeclarativeConstraintDSide, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, dSide: .init(view: to, side: toSide))
        _declarativeView._preConstraints.relative[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(side.side, to: to, side: toSide.side, preConstraint: preConstraint)
        }
        return self
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
    public func edgesToSuperview(top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        topToSuperview(top)
        leadingToSuperview(leading)
        trailingToSuperview(trailing)
        bottomToSuperview(bottom)
        return self
    }
    
    @discardableResult
    public func topToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.top] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.top, to: superview, side: .top, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func leadingToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.leading] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.leading, to: superview, side: .leading, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func trailingToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.trailing] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.trailing, to: superview, side: .trailing, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func bottomToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.bottom] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.bottom, to: superview, side: .bottom, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func centerXInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.centerX] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.centerX, to: superview, side: .centerX, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func centerYInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.centerY] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.centerY, to: superview, side: .centerY, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func widthToSuperview() -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value:0)
        _declarativeView._preConstraints.super[.width] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.width, to: superview, side: .width, preConstraint: preConstraint)
        }
        return self
    }
    
    @discardableResult
    public func heightToSuperview() -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value:0)
        _declarativeView._preConstraints.super[.height] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(.height, to: superview, side: .height, preConstraint: preConstraint)
        }
        return self
    }
    
    // MARK: - Relative
    
    @discardableResult
    public func top(to: UIView, _ side: DeclarativeConstraintYSide = .bottom, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.top, to: to, side, value)
    }
    
    @discardableResult
    public func leading(to: UIView, _ side: DeclarativeConstraintXSide = .trailing, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.leading, to: to, side, value)
    }
    
    @discardableResult
    public func trailing(to: UIView, _ side: DeclarativeConstraintXSide = .leading, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.trailing, to: to, side, value)
    }
    
    @discardableResult
    public func bottom(to: UIView, _ side: DeclarativeConstraintYSide = .top, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.bottom, to: to, side, value)
    }
    
    @discardableResult
    public func centerX(to: UIView, _ side: DeclarativeConstraintXSide = .centerX, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.centerX, to: to, side, value)
    }
    
    @discardableResult
    public func centerY(to: UIView, _ side: DeclarativeConstraintYSide = .centerY, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.centerY, to: to, side, value)
    }
    
    @discardableResult
    public func width(to: UIView, _ side: DeclarativeConstraintDSide = .width) -> Self {
        return edge(.width, to: to, side)
    }
    
    @discardableResult
    public func height(to: UIView, _ side: DeclarativeConstraintDSide = .height) -> Self {
        return edge(.height, to: to, side)
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
    public func center(in view: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        edge(.centerX, to: view,  .centerX, value)
        edge(.centerY, to: view, .centerY, value)
        return self
    }
    
    @discardableResult
    public func center(in view: UIView, x: ConstraintValue = CGFloat(0), y: ConstraintValue = CGFloat(0)) -> Self {
        edge(.centerX, to: view, .centerX, x)
        edge(.centerY, to: view, .centerY, y)
        return self
    }
    
    // MARK: - Links to constraints
    
    public var constrains: DeclarativeViewConstraints {
        return .init(_declarativeView)
    }
    
    public var height: CGFloat? {
        get { return _declarativeView._constraints[.height]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .height) }
    }
    
    public var width: CGFloat? {
        get { return _declarativeView._constraints[.width]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .width) }
    }
    
    public var top: CGFloat? {
        get { return _declarativeView._constraints[.top]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .top) }
    }
    
    public var leading: CGFloat? {
        get { return _declarativeView._constraints[.leading]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .leading) }
    }
    
    public var trailing: CGFloat? {
        get { return _declarativeView._constraints[.trailing]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .trailing) }
    }
    
    public var bottom: CGFloat? {
        get { return _declarativeView._constraints[.bottom]?.constant }
        set {
            if let _ = _declarativeView._constraints[.bottom] {
                print("bottom relation exists")
            } else {
                print("bottom relation not exists")
            }
            _declarativeView._constraints.setValue(newValue, for: .bottom) }
    }
    
    public var centerX: CGFloat? {
        get { return _declarativeView._constraints[.centerX]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .centerX) }
    }
    
    public var centerY: CGFloat? {
        get { return _declarativeView._constraints[.centerY]?.constant }
        set { _declarativeView._constraints.setValue(newValue, for: .centerY) }
    }
    
    // MARK: - Margins
    
    @discardableResult
    private func margin(top: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil) -> Self {
        if let top = top {
            _declarativeView._preConstraints.margin[.top] = top
        }
        if let left = left {
            _declarativeView._preConstraints.margin[.leading] = left
        }
        if let right = right {
            _declarativeView._preConstraints.margin[.trailing] = right
        }
        if let bottom = bottom {
            _declarativeView._preConstraints.margin[.bottom] = bottom
        }
        if let centerX = centerX {
            _declarativeView._preConstraints.margin[.centerX] = centerX
        }
        if let centerY = centerY {
            _declarativeView._preConstraints.margin[.centerY] = centerY
        }
        return self
    }
    
    @discardableResult
    private func margin(x: CGFloat? = nil, y: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil) -> Self {
        if let y = y {
            _declarativeView._preConstraints.margin[.top] = y
            _declarativeView._preConstraints.margin[.bottom] = y
        }
        if let x = x {
            _declarativeView._preConstraints.margin[.leading] = x
            _declarativeView._preConstraints.margin[.trailing] = x
        }
        if let centerX = centerX {
            _declarativeView._preConstraints.margin[.centerX] = centerX
        }
        if let centerY = centerY {
            _declarativeView._preConstraints.margin[.centerY] = centerY
        }
        return self
    }
    
    @discardableResult
    private func margin(center: CGFloat) -> Self {
        _declarativeView._preConstraints.margin[.centerX] = center
        _declarativeView._preConstraints.margin[.centerY] = center
        return self
    }
    
    @discardableResult
    private func margin(_ value: CGFloat) -> Self {
        _declarativeView._preConstraints.margin[.top] = value
        _declarativeView._preConstraints.margin[.leading] = value
        _declarativeView._preConstraints.margin[.trailing] = value
        _declarativeView._preConstraints.margin[.bottom] = value
        return self
    }
    
    // MARK: - Activation
    
    func activateSolo(superview: UIView, preConstraint: DeclarativePreConstraints.Constraint, side: NSLayoutConstraint.Attribute) {
        let margin = _declarativeView._preConstraints.margin[side] ?? 0
        let constant = preConstraint.value.value + margin
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
            if let original = _declarativeView._constraints[side] {
                _declarativeView._constraints.setValue(constraint.constant, for: side)
            } else {
                _declarativeView._constraints[side] = constraint.update(preConstraint.value).activated()
            }
        }
    }
    
    func activateRelative(_ side: NSLayoutConstraint.Attribute, to: UIView, side toSide: NSLayoutConstraint.Attribute, preConstraint: DeclarativePreConstraints.Constraint) {
        _declarativeView._constraints.removeValue(for: side)
        let margin = _declarativeView._preConstraints.margin[side] ?? 0
        let constant = preConstraint.value.value + margin
        let constraint = NSLayoutConstraint(item: declarativeView,
                                                             attribute: side,
                                                             relatedBy: preConstraint.value.relation,
                                                             toItem: to,
                                                             attribute: toSide,
                                                             multiplier: preConstraint.value.multiplier,
                                                             constant: constant)
        _declarativeView._constraints[side] = constraint.update(preConstraint.value).activated()
        if let to = to as? DeclarativeProtocolInternal {
            to._preConstraints.relative[toSide] = preConstraint
            to._constraints[toSide] = constraint.update(preConstraint.value).activated()
            print("Activated relative to (\(constant))")
        } else {
            print("Unable to activate relative to (\(constant))")
        }
    }
}
