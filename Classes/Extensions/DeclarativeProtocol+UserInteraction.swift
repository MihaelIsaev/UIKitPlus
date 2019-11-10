import UIKit

extension DeclarativeProtocol {
    public var userInteraction: State<Bool> { properties.$userInteraction }
    
    @discardableResult
    public func userInteraction(_ enabled: Bool = true) -> Self {
        declarativeView.isUserInteractionEnabled = enabled
        properties.userInteraction = enabled
        return self
    }
    
    @discardableResult
    public func userInteraction(_ state: State<Bool>) -> Self {
        declarativeView.isUserInteractionEnabled = state.wrappedValue
        properties.userInteraction = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.declarativeView.isUserInteractionEnabled = new
            self?.properties.userInteraction = new
        }
        return self
    }
    
    @discardableResult
    public func userInteraction<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        declarativeView.isUserInteractionEnabled = expressable.value()
        properties.userInteraction = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.isUserInteractionEnabled = expressable.value()
            self?.properties.userInteraction = expressable.value()
        }
        return self
    }
}
