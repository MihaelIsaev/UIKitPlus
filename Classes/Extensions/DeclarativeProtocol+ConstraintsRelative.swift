import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func equalSize(to: UIView, _ value: ConstraintValue = CGFloat(0)) -> Self {
        dimension(.width, to: to, .width, value)
        dimension(.height, to: to, .height, value)
        return self
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
}
