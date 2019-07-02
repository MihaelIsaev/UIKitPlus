import UIKit

open class WrapperView<V>: View where V: UIView, V: DeclarativeProtocol {
    public let innerView: V
    
    public init (_ innerView: V) {
        self.innerView = innerView.edgesToSuperview()
        super.init(frame: .zero)
        addSubview(innerView)
    }
    
    public init (_ innerView: () -> (V)) {
        self.innerView = innerView().edgesToSuperview()
        super.init(frame: .zero)
        addSubview(self.innerView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) -> WrapperView {
        guard top != nil || left != nil || right != nil || bottom != nil else {
            innerView.edgesToSuperview(10)
            return self
        }
        if let top = top {
            innerView.topToSuperview(top)
        }
        if let left = left {
            innerView.leadingToSuperview(left)
        }
        if let right = right {
            innerView.trailingToSuperview(right * (-1))
        }
        if let bottom = bottom {
            innerView.bottomToSuperview(bottom * (-1))
        }
        return self
    }
}