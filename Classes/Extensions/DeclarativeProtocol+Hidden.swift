import UIKit

extension DeclarativeProtocol {
    public var hidden: UState<Bool> { properties.$hidden }
    
    @discardableResult
    public func hidden(_ hidden: Bool = true) -> Self {
        declarativeView.isHidden = hidden
        properties.hidden = hidden
        return self
    }
    
    @discardableResult
    public func hidden(_ state: UState<Bool>) -> Self {
        declarativeView.isHidden = state.wrappedValue
        properties.hidden = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.declarativeView.isHidden = new
            self?.properties.hidden = new
        }
        return self
    }
    
    @discardableResult
    public func hidden<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        declarativeView.isHidden = expressable.value()
        properties.hidden = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.isHidden = expressable.value()
            self?.properties.hidden = expressable.value()
        }
        return self
    }
}
