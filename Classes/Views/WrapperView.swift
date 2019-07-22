import UIKit

open class WrapperView<V>: View where V: UIView, V: DeclarativeProtocol {
    public override var declarativeView: WrapperView { return self }
    
    public let innerView: V
    
    public init (_ innerView: V) {
        self.innerView = innerView.edgesToSuperview()
        super.init(frame: .zero)
        addSubview(innerView)
    }
    
    public convenience init (_ innerView: () -> (V)) {
        self.init(innerView())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
        innerView.layer.masksToBounds = true
        guard let customCorners = _declarativeView._customCorners else {
            innerView.layer.cornerRadius = layer.cornerRadius
            return
        }
        innerView.layer.cornerRadius = 0
        innerView.layer.mask = layer.sublayers?.first
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return innerView.becomeFirstResponder()
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return innerView.resignFirstResponder()
    }
    
    @discardableResult
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) -> Self {
        guard top != nil || left != nil || right != nil || bottom != nil else {
            return padding(10)
        }
        if let top = top {
            innerView.top = top
        }
        if let left = left {
            innerView.leading = left
        }
        if let right = right {
            innerView.trailing = right * (-1)
        }
        if let bottom = bottom {
            innerView.bottom = bottom * (-1)
        }
        return self
    }
    
    @discardableResult
    public func padding(x: CGFloat, y: CGFloat) -> Self {
        padding(x: x)
        padding(y: y)
        return self
    }
    
    @discardableResult
    public func padding(x: CGFloat) -> Self {
        innerView.leading = x
        innerView.trailing = x * (-1)
        return self
    }
    
    @discardableResult
    public func padding(y: CGFloat) -> Self {
        innerView.top = y
        innerView.bottom = y * (-1)
        return self
    }
    
    @discardableResult
    public func padding(_ value: CGFloat) -> Self {
        innerView.top = value
        innerView.leading = value
        innerView.trailing = value * (-1)
        innerView.bottom = value * (-1)
        return self
    }
}
