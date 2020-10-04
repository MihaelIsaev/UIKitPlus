import UIKit

extension DeclarativeProtocol {
    public var background: UState<UIColor> { properties.$background }
    
    @discardableResult
    public func background(_ color: UIColor) -> Self {
        declarativeView.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func background(_ number: Int) -> Self {
        declarativeView.backgroundColor = number.color
        return self
    }
    
    @discardableResult
    public func background(_ state: UState<UIColor>) -> Self {
        declarativeView.backgroundColor = state.wrappedValue
        properties.background = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.declarativeView.backgroundColor = new
            self?.properties.background = new
        }
        return self
    }
    
    @discardableResult
    public func background<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        declarativeView.backgroundColor = expressable.value()
        properties.background = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.backgroundColor = expressable.value()
            self?.properties.background = expressable.value()
        }
        return self
    }
}
