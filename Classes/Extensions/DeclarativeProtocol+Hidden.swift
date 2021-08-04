#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    public var hidden: State<Bool> { properties.$hidden }
    
    @discardableResult
    public func hidden(_ hidden: Bool = true) -> Self {
        declarativeView.isHidden = hidden
        properties.hidden = hidden
        return self
    }
    
    @discardableResult
    public func hidden(_ state: State<Bool>) -> Self {
        hidden(state.wrappedValue)
        state.listen { [weak self] new in
            self?.hidden(new)
        }
        return self
    }
}
