import UIKit

extension DeclarativeProtocol {
    public var opacity: State<Float> { properties.$opacity }
    
    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
        declarativeView.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func opacity(_ state: State<Float>) -> Self {
        declarativeView.layer.opacity = state.wrappedValue
        properties.opacity = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.declarativeView.layer.opacity = new
            self?.properties.opacity = new
        }
        return self
    }
    
    @discardableResult
    public func opacity<V>(_ expressable: ExpressableState<V, Float>) -> Self {
        declarativeView.layer.opacity = expressable.value()
        properties.opacity = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.layer.opacity = expressable.value()
            self?.properties.opacity = expressable.value()
        }
        return self
    }
}
