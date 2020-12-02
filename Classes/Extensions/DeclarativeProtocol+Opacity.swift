#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    public var opacity: State<Float> { properties.$opacity }
    
    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
        #if os(macOS)
        declarativeView.layer?.opacity = opacity
        #else
        declarativeView.layer.opacity = opacity
        #endif
        return self
    }
    
    @discardableResult
    public func opacity(_ state: State<Float>) -> Self {
        #if os(macOS)
        declarativeView.layer?.opacity = state.wrappedValue
        #else
        declarativeView.layer.opacity = state.wrappedValue
        #endif
        properties.opacity = state.wrappedValue
        state.listen { old, new in
            #if os(macOS)
            self.declarativeView.layer?.opacity = new
            #else
            self.declarativeView.layer.opacity = new
            #endif
            self.properties.opacity = new
        }
        return self
    }
    
    @discardableResult
    public func opacity<V>(_ expressable: ExpressableState<V, Float>) -> Self {
        #if os(macOS)
        declarativeView.layer?.opacity = expressable.value()
        #else
        declarativeView.layer.opacity = expressable.value()
        #endif
        properties.opacity = expressable.value()
        expressable.state.listen { old, new in
            #if os(macOS)
            self.declarativeView.layer?.opacity = expressable.value()
            #else
            self.declarativeView.layer.opacity = expressable.value()
            #endif
            self.properties.opacity = expressable.value()
        }
        return self
    }
}
