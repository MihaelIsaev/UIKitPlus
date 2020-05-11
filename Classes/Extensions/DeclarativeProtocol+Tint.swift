import UIKit

extension DeclarativeProtocol {
    public var tint: State<UIColor> { properties.$tint }
    
    @discardableResult
    public func tint(_ color: UIColor) -> Self {
        declarativeView.tintColor = color
        properties.tint = color
        #if targetEnvironment(macCatalyst)
        let textInputTraits = declarativeView.value(forKey: "textInputTraits") as? NSObject
        textInputTraits?.setValue(color, forKey: "insertionPointColor")
        #endif
        return self
    }
    
    @discardableResult
    public func tint(_ number: Int) -> Self {
        tint(number.color)
    }
    
    @discardableResult
    public func tint(_ state: State<UIColor>) -> Self {
        tint(state.wrappedValue)
        state.listen { [weak self] old, new in
            self?.tint(new)
        }
        return self
    }
    
    @discardableResult
    public func tint<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        declarativeView.tintColor = expressable.value()
        properties.tint = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.tint(expressable.value())
        }
        return self
    }
}
