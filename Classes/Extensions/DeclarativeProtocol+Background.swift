#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    public var background: State<UColor> { properties.$background }
    
    @discardableResult
    public func background(_ color: UColor) -> Self {
        #if os(macOS)
        declarativeView.wantsLayer = true
        declarativeView.layer?.backgroundColor = color.cgColor
        #else
        declarativeView.backgroundColor = color
        #endif
        return self
    }
    
    @discardableResult
    public func background(_ number: Int) -> Self {
        background(number.color)
    }
    
    @discardableResult
    public func background(_ state: State<UColor>) -> Self {
        background(state.wrappedValue)
        properties.background = state.wrappedValue
        state.listen { [weak self] old, new in
            self?.background(new)
            self?.properties.background = new
        }
        return self
    }
    
    @discardableResult
    public func background<V>(_ expressable: ExpressableState<V, UColor>) -> Self {
        declarativeView.background(expressable.value())
        properties.background = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.background(expressable.value())
            self?.properties.background = expressable.value()
        }
        return self
    }
}
