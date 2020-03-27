import UIKit

public typealias UWrapperView = WrapperView
open class WrapperView<V>: View where V: UIView {
    public override var declarativeView: WrapperView { return self }
    
    public let innerView: V
    
    var topConstraint, leadingConstraint, trailingConstraint, bottomConstraint: NSLayoutConstraint!
    
    public init (_ innerView: V) {
        self.innerView = innerView
        super.init(frame: .zero)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        body { innerView }
        backgroundColor = .clear
        topConstraint = innerView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        leadingConstraint = innerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        trailingConstraint = innerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        bottomConstraint = innerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
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
            topConstraint.constant = top
        }
        if let left = left {
            leadingConstraint.constant = left
        }
        if let right = right {
            trailingConstraint.constant = right * (-1)
        }
        if let bottom = bottom {
            bottomConstraint.constant = bottom * (-1)
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
        leadingConstraint.constant = x
        trailingConstraint.constant = x * (-1)
        return self
    }
    
    @discardableResult
    public func padding(y: CGFloat) -> Self {
        topConstraint.constant = y
        bottomConstraint.constant = y * (-1)
        return self
    }
    
    @discardableResult
    public func padding(_ value: CGFloat) -> Self {
        topConstraint.constant = value
        leadingConstraint.constant = value
        trailingConstraint.constant = value * (-1)
        bottomConstraint.constant = value * (-1)
        return self
    }
}
