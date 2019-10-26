import UIKit

extension DeclarativeProtocol {
    public var tint: State<UIColor> { properties.$tint }
    
    @discardableResult
    public func tint(_ color: UIColor) -> Self {
        declarativeView.tintColor = color
        return self
    }
    
    @discardableResult
    public func tint(_ number: Int) -> Self {
        declarativeView.tintColor = number.color
        return self
    }
    
    @discardableResult
    public func tint(_ state: State<UIColor>) -> Self {
        declarativeView.tintColor = state.wrappedValue
        properties.tint = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.declarativeView.tintColor = new
            self?.properties.tint = new
        }
        return self
    }
    
    @discardableResult
    public func tint<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        declarativeView.tintColor = expressable.value()
        properties.tint = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.tintColor = expressable.value()
            self?.properties.tint = expressable.value()
        }
        return self
    }
}
