import UIKit

extension DeclarativeProtocol {
    private func _createSuper(value: State<CGFloat>,
                                                    relation: NSLayoutConstraint.Relation,
                                                    multiplier: CGFloat,
                                                    priority: UILayoutPriority,
                                                    attribute1: NSLayoutConstraint.Attribute,
                                                    attribute2: NSLayoutConstraint.Attribute?,
                                                    toSafe: Bool,
                                                    destinationView: UIView?) -> Self {
        let pc = PreConstraint(value: value,
                                        relation: relation,
                                        multiplier: multiplier,
                                        priority: priority,
                                        attribute1: attribute1,
                                        attribute2: attribute2,
                                        toSafe: toSafe,
                                        fromView: declarativeView,
                                        destinationView: destinationView)
        if let _ = declarativeView.superview {
            declarativeView.activateSuper(pc)
        } else {
            _declarativeView._properties.notAppliedPreConstraintsSuper.append(pc)
        }
        return self
    }
    
    private func _createSuper<V>(expressable: ExpressableState<V, CGFloat>,
                                                    relation: NSLayoutConstraint.Relation,
                                                    multiplier: CGFloat,
                                                    priority: UILayoutPriority,
                                                    attribute1: NSLayoutConstraint.Attribute,
                                                    attribute2: NSLayoutConstraint.Attribute?,
                                                    toSafe: Bool,
                                                    destinationView: UIView?) -> Self {
        _createSuper(value: expressable.unwrap(),
                                                relation: relation,
                                                multiplier: multiplier,
                                                priority: priority,
                                                attribute1: attribute1,
                                                attribute2: attribute2,
                                                toSafe: toSafe,
                                                destinationView: destinationView)
    }
    
    // MARK: -
    
    @discardableResult
    public func edgesToSuperview(_ value: CGFloat = 0) -> Self {
        topToSuperview(value)
        leadingToSuperview(value)
        trailingToSuperview(value * (-1))
        bottomToSuperview(value * (-1))
        return self
    }
    
    public func edgesToSuperview(_ value: State<CGFloat>) -> Self {
        topToSuperview(value)
        leadingToSuperview(value)
        trailingToSuperview(value.map { -1 * $0 })
        bottomToSuperview(value.map { -1 * $0 })
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
    public func edgesToSuperview(top: State<CGFloat>? = nil, leading: State<CGFloat>? = nil, trailing: State<CGFloat>? = nil, bottom: State<CGFloat>? = nil, safeArea: Bool = false) -> Self {
        if let top = top {
            topToSuperview(top, safeArea: safeArea)
        }
        if let leading = leading {
            leadingToSuperview(leading, safeArea: safeArea)
        }
        if let trailing = trailing {
            trailingToSuperview(trailing, safeArea: safeArea)
        }
        if let bottom = bottom {
            bottomToSuperview(bottom, safeArea: safeArea)
        }
        return self
    }
    
    // MARK: - top
    
    @discardableResult
    public func topToSuperview(_ state: State<CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(value: state,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .top,
                     attribute2: .top,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func topToSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(expressable: expressable,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .top,
                     attribute2: .top,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func topToSuperview(_ value: ConstraintValue = CGFloat(0), safeArea: Bool = false) -> Self {
        topToSuperview(State<CGFloat>(wrappedValue: value.constraintValue.value),
                                relation: value.constraintValue.relation,
                                multiplier: value.constraintValue.multiplier,
                                priority: value.constraintValue.priority,
                                safeArea: safeArea)
    }
    
    // MARK: - leading
    
    @discardableResult
    public func leadingToSuperview(_ state: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        _createSuper(value: state,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .leading,
                     attribute2: .leading,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func leadingToSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(expressable: expressable,
                        relation: relation,
                        multiplier: multiplier,
                        priority: priority,
                        attribute1: .leading,
                        attribute2: .leading,
                        toSafe: safeArea,
                        destinationView: declarativeView.superview)
    }
        
    @discardableResult
    public func leadingToSuperview(_ value: ConstraintValue = CGFloat(0), safeArea: Bool = false) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: value.constraintValue.value),
                     relation: value.constraintValue.relation,
                     multiplier: value.constraintValue.multiplier,
                     priority: value.constraintValue.priority,
                     attribute1: .leading,
                     attribute2: .leading,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    // MARK: - trailing
    
    @discardableResult
    public func trailingToSuperview(_ state: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        _createSuper(value: state,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .trailing,
                     attribute2: .trailing,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func trailingToSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(expressable: expressable,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .trailing,
                     attribute2: .trailing,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func trailingToSuperview(_ value: ConstraintValue = CGFloat(0), safeArea: Bool = false) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: value.constraintValue.value),
                     relation: value.constraintValue.relation,
                     multiplier: value.constraintValue.multiplier,
                     priority: value.constraintValue.priority,
                     attribute1: .trailing,
                     attribute2: .trailing,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    // MARK: - bottom
    
    @discardableResult
    public func bottomToSuperview(_ state: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        _createSuper(value: state,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .bottom,
                     attribute2: .bottom,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func bottomToSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(expressable: expressable,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .bottom,
                     attribute2: .bottom,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func bottomToSuperview(_ value: ConstraintValue = CGFloat(0), safeArea: Bool = false) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: value.constraintValue.value),
                     relation: value.constraintValue.relation,
                     multiplier: value.constraintValue.multiplier,
                     priority: value.constraintValue.priority,
                     attribute1: .bottom,
                     attribute2: .bottom,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    // MARK: - center x
    
    @discardableResult
    public func centerXInSuperview(_ state: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        _createSuper(value: state,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .centerX,
                     attribute2: .centerX,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func centerXInSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(expressable: expressable,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .centerX,
                     attribute2: .centerX,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func centerXInSuperview(_ value: ConstraintValue = CGFloat(0), safeArea: Bool = false) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: value.constraintValue.value),
                     relation: value.constraintValue.relation,
                     multiplier: value.constraintValue.multiplier,
                     priority: value.constraintValue.priority,
                     attribute1: .centerX,
                     attribute2: .centerX,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    // MARK: - center y
    
    @discardableResult
    public func centerYInSuperview(_ state: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        _createSuper(value: state,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .centerY,
                     attribute2: .centerY,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func centerYInSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh,
                                            safeArea: Bool = false) -> Self {
        _createSuper(expressable: expressable,
                     relation: relation,
                     multiplier: multiplier,
                     priority: priority,
                     attribute1: .centerY,
                     attribute2: .centerY,
                     toSafe: safeArea,
                     destinationView: declarativeView.superview)
    }
    
    @discardableResult
    public func centerYInSuperview(_ value: ConstraintValue = CGFloat(0), safeArea: Bool = false) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: value.constraintValue.value),
                                        relation: value.constraintValue.relation,
                                        multiplier: value.constraintValue.multiplier,
                                        priority: value.constraintValue.priority,
                                        attribute1: .centerY,
                                        attribute2: .centerY,
                                        toSafe: safeArea,
                                        destinationView: declarativeView.superview)
    }
    
    // MARK: center both
    
    @discardableResult
    public func centerInSuperview(_ state: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        centerXInSuperview(state, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        centerYInSuperview(state, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        return self
    }
    
    @discardableResult
    public func centerInSuperview<V>(_ expressable: ExpressableState<V, CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        centerXInSuperview(expressable, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        centerYInSuperview(expressable, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        return self
    }
    
    @discardableResult
    public func centerInSuperview(_ value: ConstraintValue = CGFloat(0)) -> Self {
        centerXInSuperview(value)
        centerYInSuperview(value)
        return self
    }
    
    @discardableResult
    public func centerInSuperview(x: ConstraintValue, y: ConstraintValue) -> Self {
        centerXInSuperview(x)
        centerYInSuperview(y)
        return self
    }
    
    @discardableResult
    public func centerInSuperview(x: State<CGFloat>,
                                                y: State<CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        centerXInSuperview(x, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        centerYInSuperview(y, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        return self
    }
    
    @discardableResult
    public func centerInSuperview<A, B>(x: ExpressableState<A, CGFloat>,
                                                y: ExpressableState<B, CGFloat>,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh,
                                                safeArea: Bool = false) -> Self {
        centerXInSuperview(x, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        centerYInSuperview(y, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        return self
    }
    
    @discardableResult
    public func centerInSuperview<V>(x: ExpressableState<V, CGFloat>,
                                                    y: State<CGFloat>,
                                                    relation: NSLayoutConstraint.Relation = .equal,
                                                    multiplier: CGFloat = 1,
                                                    priority: UILayoutPriority = .defaultHigh,
                                                    safeArea: Bool = false) -> Self {
        centerXInSuperview(x, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        centerYInSuperview(y, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        return self
    }
    
    @discardableResult
    public func centerInSuperview<V>(x: State<CGFloat>,
                                                    y: ExpressableState<V, CGFloat>,
                                                    relation: NSLayoutConstraint.Relation = .equal,
                                                    multiplier: CGFloat = 1,
                                                    priority: UILayoutPriority = .defaultHigh,
                                                    safeArea: Bool = false) -> Self {
        centerXInSuperview(x, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        centerYInSuperview(y, relation: relation, multiplier: multiplier, priority: priority, safeArea: safeArea)
        return self
    }
    
    // MARK: - width
    
    @discardableResult
    public func widthToSuperview(multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: 0),
                                        relation: .equal,
                                        multiplier: multipliedBy,
                                        priority: priority,
                                        attribute1: .width,
                                        attribute2: .width,
                                        toSafe: false,
                                        destinationView: declarativeView.superview)
    }
    
    // MARK: - height
    
    @discardableResult
    public func heightToSuperview(multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        _createSuper(value: State<CGFloat>(wrappedValue: 0),
                                        relation: .equal,
                                        multiplier: multipliedBy,
                                        priority: priority,
                                        attribute1: .height,
                                        attribute2: .height,
                                        toSafe: false,
                                        destinationView: declarativeView.superview)
    }
    
    // MARK: - Activation
    
    func activateSuper(_ pc: PreConstraint) {
        guard let superview = declarativeView.superview else { return }
        guard let _self = self as? DeclarativeProtocolInternal else { return }
        // Deactivate duplicate constraint and remove it from array
        _self._properties.notAppliedPreConstraintsSuper.removeAll { $0 != pc && $0.attribute1 == pc.attribute1 && $0.relation == pc.relation }
        if let index = _self._properties.appliedPreConstraintsSuper.firstIndex(where: { $0.attribute1 == pc.attribute1 && $0.relation == pc.relation }) {
            _self._properties.appliedPreConstraintsSuper[index].constraint?.isActive = false
            _self._properties.appliedPreConstraintsSuper[index].constraint?.shouldBeArchived = true
            _self._properties.appliedPreConstraintsSuper.remove(at: index)
        }
        // Move pre constraint from not applied to applied
        _self._properties.notAppliedPreConstraintsSuper.removeAll(where: { $0 === pc })
        _self._properties.appliedPreConstraintsSuper.append(pc)
        // Store destination view into pre constraint
        pc.destinationView = superview
        // Create constraint
        var constraint: NSLayoutConstraint?
        // If constraint for safeArea then create it through anchor
        if pc.toSafe {
            switch pc.attribute1 {
            case .top:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.topAnchor.constraint(equalTo: superview.safeArea.topAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                     constraint = declarativeView.topAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.topAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.topAnchor.constraint(lessThanOrEqualTo: superview.safeArea.topAnchor, constant: pc.value.wrappedValue)
                @unknown default: break
                }
            case .leading:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.leadingAnchor.constraint(equalTo: superview.safeArea.leadingAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.leadingAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.leadingAnchor.constraint(lessThanOrEqualTo: superview.safeArea.leadingAnchor, constant: pc.value.wrappedValue)
                @unknown default: break
                }
            case .left:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.leftAnchor.constraint(equalTo: superview.safeArea.leftAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.leftAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.leftAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.leftAnchor.constraint(lessThanOrEqualTo: superview.safeArea.leftAnchor, constant: pc.value.wrappedValue)
                @unknown default: break
                }
            case .trailing:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.trailingAnchor.constraint(equalTo: superview.safeArea.trailingAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.trailingAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.trailingAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.trailingAnchor.constraint(lessThanOrEqualTo: superview.safeArea.trailingAnchor, constant: pc.value.wrappedValue)
                @unknown default: break
                }
            case .right:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.rightAnchor.constraint(equalTo: superview.safeArea.rightAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.rightAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.rightAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.rightAnchor.constraint(lessThanOrEqualTo: superview.safeArea.rightAnchor, constant: pc.value.wrappedValue)
                @unknown default: break
                }
            case .bottom:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.bottomAnchor.constraint(equalTo: superview.safeArea.bottomAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.bottomAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.bottomAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.bottomAnchor.constraint(lessThanOrEqualTo: superview.safeArea.bottomAnchor, constant: pc.value.wrappedValue)
                @unknown default: break
                }
            default: break
            }
        }
        // If constraint was not for safeArea then create it as usual
        if constraint == nil {
            constraint = NSLayoutConstraint(item: self,
                                                            attribute: pc.attribute1,
                                                            relatedBy: pc.relation,
                                                            toItem: superview,
                                                            attribute: pc.attribute2 ?? .notAnAttribute,
                                                            multiplier: pc.multiplier,
                                                            constant: pc.value.wrappedValue)
        }
        // Store constraint into pre constraint
        pc.constraint = constraint
        // Activate constraint
        constraint?.isActive = true
        // Link internal state with external
        linkStates(pc.attribute1, _self, pc.value)
        // Redraw itself
        superview.layoutIfNeeded()
    }
    
    func linkStates(_ attr: NSLayoutConstraint.Attribute, _ _self: DeclarativeProtocolInternal, _ state: State<CGFloat>) {
        let internalState: State<CGFloat>
        switch attr {
        case .top: internalState = _self.__top
        case .leading: internalState = _self.__leading
        case .left: internalState = _self.__left
        case .trailing: internalState = _self.__trailing
        case .right: internalState = _self.__right
        case .bottom: internalState = _self.__bottom
        case .height: internalState = _self.__height
        case .width: internalState = _self.__width
        case .centerX: internalState = _self.__centerX
        case .centerY: internalState = _self.__centerY
        default: return
        }
        internalState.wrappedValue = state.wrappedValue
        var justSetExternal = false
        var justSetInternal = false
        state.listen { new in
            guard !justSetInternal else { return }
            justSetExternal = true
            internalState.wrappedValue = new
            justSetExternal = false
        }
        internalState.listen { new in
            guard !justSetExternal else { return }
            justSetInternal = true
            state.wrappedValue = new
            justSetInternal = false
        }
    }
}
