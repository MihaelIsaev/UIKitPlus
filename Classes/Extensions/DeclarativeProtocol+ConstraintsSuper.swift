import UIKit

extension DeclarativeProtocol {
    func _edgeSuperviewNew<V>(expressable: ExpressableState<V, CGFloat>,
                                                    relation: NSLayoutConstraint.Relation,
                                                    multiplier: CGFloat,
                                                    priority: UILayoutPriority,
                                                    attribute1: NSLayoutConstraint.Attribute,
                                                    attribute2: NSLayoutConstraint.Attribute?,
                                                    toSafe: Bool,
                                                    destinationView: UIView?) -> Self {
        return _edgeSuperviewNew(value: expressable.unwrap(),
                                                relation: relation,
                                                multiplier: multiplier,
                                                priority: priority,
                                                attribute1: attribute1,
                                                attribute2: attribute2,
                                                toSafe: toSafe,
                                                destinationView: destinationView)
    }
    
    func _edgeSuperviewNew(value: State<CGFloat>,
                                                    relation: NSLayoutConstraint.Relation,
                                                    multiplier: CGFloat,
                                                    priority: UILayoutPriority,
                                                    attribute1: NSLayoutConstraint.Attribute,
                                                    attribute2: NSLayoutConstraint.Attribute?,
                                                    toSafe: Bool,
                                                    destinationView: UIView?) -> Self {
        let pc = PropertiesInternal.PC(value: value,
                                                    relation: relation,
                                                    multiplier: multiplier,
                                                    priority: priority,
                                                    attribute1: attribute1,
                                                    attribute2: attribute2,
                                                    toSafe: toSafe,
                                                    fromView: declarativeView,
                                                    destinationView: destinationView)
        if let _ = declarativeView.superview {
            declarativeView.activateSuperNew(pc)
        } else {
            _declarativeView._properties.notAppliedPreConstraintsSuper.append(pc)
        }
        return self
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
    
//    public func edgesToSuperview(_ value: State<CGFloat> = .init(initialValue: 0)) -> Self {
//        topToSuperview(value)
//        leadingToSuperview(value)
//        trailingToSuperview(value * (-1))
//        bottomToSuperview(value * (-1))
//        return self
//    }
        
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
    
    // MARK: - top
    
    @discardableResult
    public func topToSuperview(_ state: State<CGFloat>,
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(value: state,
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
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(expressable: expressable,
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
        topToSuperview(State<CGFloat>(initialValue: value.constraintValue.value),
                                safeArea: safeArea,
                                relation: value.constraintValue.relation,
                                multiplier: value.constraintValue.multiplier,
                                priority: value.constraintValue.priority)
    }
    
    // MARK: - leading
    
    @discardableResult
    public func leadingToSuperview(_ state: State<CGFloat>,
                                                safeArea: Bool = false,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(value: state,
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
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(expressable: expressable,
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
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: value.constraintValue.value),
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
                                                safeArea: Bool = false,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(value: state,
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
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(expressable: expressable,
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
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: value.constraintValue.value),
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
                                                safeArea: Bool = false,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(value: state,
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
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(expressable: expressable,
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
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: value.constraintValue.value),
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
                                                safeArea: Bool = false,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(value: state,
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
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(expressable: expressable,
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
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: value.constraintValue.value),
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
                                                safeArea: Bool = false,
                                                relation: NSLayoutConstraint.Relation = .equal,
                                                multiplier: CGFloat = 1,
                                                priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(value: state,
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
                                            safeArea: Bool = false,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            multiplier: CGFloat = 1,
                                            priority: UILayoutPriority = .defaultHigh) -> Self {
        _edgeSuperviewNew(expressable: expressable,
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
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: value.constraintValue.value),
                                        relation: value.constraintValue.relation,
                                        multiplier: value.constraintValue.multiplier,
                                        priority: value.constraintValue.priority,
                                        attribute1: .centerY,
                                        attribute2: .centerY,
                                        toSafe: safeArea,
                                        destinationView: declarativeView.superview)
    }
    
    // MARK: - width
    
    @discardableResult
    public func widthToSuperview(multipliedBy: CGFloat = 1, priority: UILayoutPriority = .init(1000)) -> Self {
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: 0),
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
        _edgeSuperviewNew(value: State<CGFloat>(initialValue: 0),
                                        relation: .equal,
                                        multiplier: multipliedBy,
                                        priority: priority,
                                        attribute1: .height,
                                        attribute2: .height,
                                        toSafe: false,
                                        destinationView: declarativeView.superview)
    }
    
    // MARK: - Activation
    
    func activateSuperNew(_ pc: PropertiesInternal.PC) {
        guard let superview = declarativeView.superview else { return }
        guard let _self = self as? DeclarativeProtocolInternal else { return }
        _self._properties.notAppliedPreConstraintsSuper.removeAll(where: { $0 === pc })
        _self._properties.appliedPreConstraintsSuper.append(pc)
        pc.destinationView = superview
        var constraint: NSLayoutConstraint?
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
                }
            case .leading:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.leadingAnchor.constraint(equalTo: superview.safeArea.leadingAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.leadingAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.leadingAnchor.constraint(lessThanOrEqualTo: superview.safeArea.leadingAnchor, constant: pc.value.wrappedValue)
                }
            case .left:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.leftAnchor.constraint(equalTo: superview.safeArea.leftAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.leftAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.leftAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.leftAnchor.constraint(lessThanOrEqualTo: superview.safeArea.leftAnchor, constant: pc.value.wrappedValue)
                }
            case .trailing:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.trailingAnchor.constraint(equalTo: superview.safeArea.trailingAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.trailingAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.trailingAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.trailingAnchor.constraint(lessThanOrEqualTo: superview.safeArea.trailingAnchor, constant: pc.value.wrappedValue)
                }
            case .right:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.rightAnchor.constraint(equalTo: superview.safeArea.rightAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.rightAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.rightAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.rightAnchor.constraint(lessThanOrEqualTo: superview.safeArea.rightAnchor, constant: pc.value.wrappedValue)
                }
            case .bottom:
                switch pc.relation {
                case .equal:
                    constraint = declarativeView.bottomAnchor.constraint(equalTo: superview.safeArea.bottomAnchor, constant: pc.value.wrappedValue)
                case .greaterThanOrEqual:
                    constraint = declarativeView.bottomAnchor.constraint(greaterThanOrEqualTo: superview.safeArea.bottomAnchor, constant: pc.value.wrappedValue)
                case .lessThanOrEqual:
                    constraint = declarativeView.bottomAnchor.constraint(lessThanOrEqualTo: superview.safeArea.bottomAnchor, constant: pc.value.wrappedValue)
                }
            default: break
            }
        }
        if constraint == nil {
            constraint = NSLayoutConstraint(item: self,
                                                            attribute: pc.attribute1,
                                                            relatedBy: pc.relation,
                                                            toItem: superview,
                                                            attribute: pc.attribute2 ?? .notAnAttribute,
                                                            multiplier: pc.multiplier,
                                                            constant: pc.value.wrappedValue)
            
        }
        pc.constraint = constraint
        constraint?.isActive = true
    }
}
