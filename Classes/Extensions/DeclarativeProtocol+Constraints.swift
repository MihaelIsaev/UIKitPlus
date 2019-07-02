import UIKit

extension DeclarativeProtocol {
    // MARK: - Size
    
    @discardableResult
    public func size(_ w: ConstraintValue, _ h: ConstraintValue) -> Self {
        _declarativeView._preConstraints.solo[.width] = .init(value: w)
        _declarativeView._preConstraints.solo[.height] = .init(value: h)
        _declarativeView._constraints[.width]?.constant = h.constraintValue.value
        return self
    }
    
    public func size(_ value: ConstraintValue) -> Self {
        _declarativeView._preConstraints.solo[.width] = .init(value: value)
        _declarativeView._preConstraints.solo[.height] = .init(value: value)
        return self
    }
    
    @discardableResult
    public func sameSize(as: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        edge(.width, to: `as`.widthAnchor, value)
        edge(.height, to: `as`.heightAnchor, value)
        return self
    }
    
    @discardableResult
    public func width(_ value: ConstraintValue) -> Self {
        _declarativeView._preConstraints.solo[.width] = .init(value: value)
        return self
    }
    
    @discardableResult
    public func height(_ value: ConstraintValue) -> Self {
        _declarativeView._preConstraints.solo[.height] = .init(value: value)
        return self
    }
    
    // MARK: - Edges
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintXSide, toSuperview anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, xAnchor: anchor)
        _declarativeView._preConstraints.super[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: side.side)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintYSide, toSuperview anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, yAnchor: anchor)
        _declarativeView._preConstraints.super[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: side.side)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintDSide, toSuperview anchor: NSLayoutAnchor<NSLayoutDimension>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, dimension: anchor)
        _declarativeView._preConstraints.super[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: side.side)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintXSide, to: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, xAnchor: to)
        _declarativeView._preConstraints.relative[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(superview: superview, preConstraint: preConstraint, side: side.side)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintYSide, to: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, yAnchor: to)
        _declarativeView._preConstraints.relative[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(superview: superview, preConstraint: preConstraint, side: side.side)
        }
        return self
    }
    
    @discardableResult
    public func edge(_ side: DeclarativeConstraintDSide, to: NSLayoutAnchor<NSLayoutDimension>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue, dimension: to)
        _declarativeView._preConstraints.relative[side.side] = preConstraint
        if let superview = declarativeView.superview {
            activateRelative(superview: superview, preConstraint: preConstraint, side: side.side)
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
            activateSuper(superview: superview, preConstraint: preConstraint, side: .top)
        }
        return self
    }
    
    @discardableResult
    public func leadingToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.leading] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .leading)
        }
        return self
    }
    
    @discardableResult
    public func trailingToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.trailing] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .trailing)
        }
        return self
    }
    
    @discardableResult
    public func bottomToSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.bottom] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .bottom)
        }
        return self
    }
    
    @discardableResult
    public func centerXInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.centerX] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .centerX)
        }
        return self
    }
    
    @discardableResult
    public func centerYInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value: value.constraintValue)
        _declarativeView._preConstraints.super[.centerY] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .centerY)
        }
        return self
    }
    
    @discardableResult
    public func widthToSuperview() -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value:0)
        _declarativeView._preConstraints.super[.width] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .width)
        }
        return self
    }
    
    @discardableResult
    public func heightToSuperview() -> Self {
        let preConstraint = DeclarativePreConstraints.Constraint(value:0)
        _declarativeView._preConstraints.super[.height] = preConstraint
        if let superview = declarativeView.superview {
            activateSuper(superview: superview, preConstraint: preConstraint, side: .height)
        }
        return self
    }
    
    // MARK: - Relative
    
    @discardableResult
    public func top(to: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.top, to: to, value)
    }
    
    @discardableResult
    public func leading(to: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.leading, to: to, value)
    }
    
    @discardableResult
    public func trailing(to: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.trailing, to: to, value)
    }
    
    @discardableResult
    public func bottom(to: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.bottom, to: to, value)
    }
    
    @discardableResult
    public func centerX(to: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.centerX, to: to, value)
    }
    
    @discardableResult
    public func centerY(to: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ value: ConstraintValue = CGFloat(0)) -> Self {
        return edge(.centerY, to: to, value)
    }
    
    @discardableResult
    public func width(to: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        return edge(.width, to: to)
    }
    
    @discardableResult
    public func height(to: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        return edge(.height, to: to)
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
        edge(.centerX, to: view.centerXAnchor, value)
        edge(.centerY, to: view.centerYAnchor, value)
        return self
    }
    
    @discardableResult
    public func center(in view: UIView, x: ConstraintValue = CGFloat(0), y: ConstraintValue = CGFloat(0)) -> Self {
        edge(.centerX, to: view.centerXAnchor, x)
        edge(.centerY, to: view.centerYAnchor, y)
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
        set { _declarativeView._constraints.setValue(newValue, for: .bottom) }
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
        _declarativeView._constraints.removeValue(forKey: side)
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
            _declarativeView._constraints[side] = constraint.update(preConstraint.value).activated()
        }
    }
    
    func activateSuper(superview: UIView, preConstraint: DeclarativePreConstraints.Constraint, side: NSLayoutConstraint.Attribute) {
        _declarativeView._constraints.removeValue(for: side)
        let margin = _declarativeView._preConstraints.margin[side] ?? 0
        let constant = preConstraint.value.value + margin
        let constraint = NSLayoutConstraint(item: declarativeView,
                                            attribute: side,
                                            relatedBy: preConstraint.value.relation,
                                            toItem: superview,
                                            attribute: side,
                                            multiplier: preConstraint.value.multiplier,
                                            constant: constant)
        _declarativeView._constraints[side] = constraint.update(preConstraint.value).activated()
    }
    
    func activateRelative(superview: UIView, preConstraint: DeclarativePreConstraints.Constraint, side: NSLayoutConstraint.Attribute) {
        _declarativeView._constraints.removeValue(for: side)
        let margin = _declarativeView._preConstraints.margin[side] ?? 0
        let constant = preConstraint.value.value + margin
        var constraint: NSLayoutConstraint?
        switch side {
        case .width, .height:
            let anchor1 = declarativeView.dimensionBy(side)!
            let anchor2 = preConstraint.dimension!
            switch preConstraint.value.relation {
            case .equal: constraint = anchor1.constraint(equalTo: anchor2, constant: constant)
            case .greaterThanOrEqual: constraint = anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
            case .lessThanOrEqual: constraint = anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)
            }
        case .top, .bottom, .centerY:
            let anchor1 = declarativeView.yAnchorBy(side)!
            let anchor2 = preConstraint.yAnchor!
            switch preConstraint.value.relation {
            case .equal: constraint = anchor1.constraint(equalTo: anchor2, constant: constant)
            case .greaterThanOrEqual: constraint = anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
            case .lessThanOrEqual: constraint = anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)
            }
        case .leading, .trailing, .centerX:
            let anchor1 = declarativeView.xAnchorBy(side)!
            let anchor2 = preConstraint.xAnchor!
            switch preConstraint.value.relation {
            case .equal: constraint = anchor1.constraint(equalTo: anchor2, constant: constant)
            case .greaterThanOrEqual: constraint = anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
            case .lessThanOrEqual: constraint = anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)
            }
        default: break
        }
        if let constraint = constraint {
            _declarativeView._constraints[side] = constraint.update(preConstraint.value).activated()
        }
    }
}
