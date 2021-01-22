#if !os(macOS)
import UIKit

extension DeclarativeProtocol {
    public var tint: State<UColor> { properties.$tint }
    
    @discardableResult
    public func tint(_ color: UColor) -> Self {
        declarativeView.tintColor = color
        properties.tint = color
        #if targetEnvironment(macCatalyst)
        // FIXME: it crashes on UImage on `textInputTraits` since it doesn't have it
        if self is UImage == false, self is UButton == false {
            let textInputTraits = declarativeView.value(forKey: "textInputTraits") as? NSObject
            textInputTraits?.setValue(color, forKey: "insertionPointColor")
        }
        #endif
        return self
    }
    
    @discardableResult
    public func tint(_ number: Int) -> Self {
        tint(number.color)
    }
    
    @discardableResult
    public func tint(_ state: State<UColor>) -> Self {
        tint(state.wrappedValue)
        state.listen { old, new in
            self.tint(new)
        }
        return self
    }
    
    @discardableResult
    public func tint<V>(_ expressable: ExpressableState<V, UColor>) -> Self {
        declarativeView.tintColor = expressable.value()
        properties.tint = expressable.value()
        expressable.state.listen { old, new in
            self.tint(expressable.value())
        }
        return self
    }
}
#endif
