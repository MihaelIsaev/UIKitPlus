import UIKit

public protocol Colorable {
    @discardableResult
    func color(_ color: UIColor) -> Self
    
    @discardableResult
    func color(_ number: Int) -> Self
    
    @discardableResult
    func color(_ color: UState<UIColor>) -> Self
    
    @discardableResult
    func color<V>(_ expressable: ExpressableState<V, UIColor>) -> Self
}

protocol _Colorable: Colorable {
    var _colorState: UState<UIColor> { get }
    
    func _setColor(_ v: UIColor?)
}

extension Colorable {
    @discardableResult
    public func color(_ number: Int) -> Self {
        color(number.color)
    }
    
    @discardableResult
    public func color(_ state: UState<UIColor>) -> Self {
        state.listen { self.color($0) }
        return color(state.wrappedValue)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        color(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Colorable {
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        guard let s = self as? _Colorable else { return self }
        s._setColor(color)
        return self
    }
}

// for iOS lower than 13
extension _Colorable {
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        _setColor(color)
        return self
    }
}
