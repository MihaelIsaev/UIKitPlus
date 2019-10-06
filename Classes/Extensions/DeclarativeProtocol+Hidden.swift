import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func hidden(_ hidden: Bool = true) -> Self {
        declarativeView.isHidden = hidden
        return self
    }
    
    @discardableResult
    public func hidden(_ hidden: State<Bool>) -> Self {
        declarativeView.isHidden = hidden.wrappedValue
        hidden.listen { [weak self] old, new in
            self?.declarativeView.isHidden = new
        }
        return self
    }
    
    @discardableResult
    public func hidden<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        declarativeView.isHidden = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.isHidden = expressable.value()
        }
        return self
    }
}
