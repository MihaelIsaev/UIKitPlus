#if !os(macOS)
import UIKit

extension DeclarativeProtocol {
    public var alpha: State<CGFloat> { properties.$alpha }
    
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        declarativeView.alpha = alpha
        return self
    }
    
    @discardableResult
    public func alpha(_ state: State<CGFloat>) -> Self {
        declarativeView.alpha = state.wrappedValue
        properties.alpha = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.declarativeView.alpha = new
            self?.properties.alpha = new
        }
        return self
    }
    
    @discardableResult
    public func alpha<V>(_ expressable: ExpressableState<V, CGFloat>) -> Self {
        declarativeView.alpha = expressable.value()
        properties.alpha = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.alpha = expressable.value()
            self?.properties.alpha = expressable.value()
        }
        return self
    }
}
#endif
