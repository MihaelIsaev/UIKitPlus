import UIKit

extension DeclarativeProtocol {
    public var hidden: State<Bool> { properties.$hidden }
    
    @discardableResult
    public func hidden(_ hidden: Bool = true) -> Self {
        declarativeView.isHidden = hidden
        properties.hidden = hidden
        return self
    }
    
    @discardableResult
    public func hidden(_ hidden: State<Bool>) -> Self {
        declarativeView.isHidden = hidden.wrappedValue
        properties.hidden = hidden.wrappedValue
        hidden.listen { [weak self] old, new in
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
