#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    public var background: State<UColor> { properties.$background }
    
    @discardableResult
    public func background(_ number: Int) -> Self {
        background(number.color)
    }
    
    @discardableResult
    public func background(_ color: UColor) -> Self {
        _setBackground(.init(wrappedValue: color))
        return self
    }
    
    @discardableResult
    public func background(_ state: State<UColor>) -> Self {
        _setBackground(state)
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
    
    private func _setBackground(_ color: State<UColor>) {
        #if os(macOS)
        background.wrappedValue.changeHandler = nil
        properties.background = color.wrappedValue
        declarativeView.wantsLayer = true
        declarativeView.layer?.backgroundColor = color.wrappedValue.current.cgColor
        properties.background.onChange { [weak self] new in
            self?.declarativeView.layer?.backgroundColor = new.cgColor
        }
        #else
        properties.background = color.wrappedValue
        declarativeView.backgroundColor = color
        #endif
    }
}
