#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Colorable {
    @discardableResult
    func color(_ color: UColor) -> Self
    
    @discardableResult
    func color(_ number: Int) -> Self
    
    @discardableResult
    func color(_ color: State<UColor>) -> Self
    
    @discardableResult
    func color<V>(_ expressable: ExpressableState<V, UColor>) -> Self
}

protocol _Colorable: Colorable {
    var _colorState: State<UColor> { get }
    
    func _setColor(_ v: UColor?)
}

extension Colorable {
    @discardableResult
    public func color(_ number: Int) -> Self {
        color(number.color)
    }
    
    @discardableResult
    public func color(_ state: State<UColor>) -> Self {
        state.listen { self.color($0) }
        return color(state.wrappedValue)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, UColor>) -> Self {
        color(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Colorable {
    @discardableResult
    public func color(_ color: UColor) -> Self {
        guard let s = self as? _Colorable else { return self }
        s._setColor(color)
        return self
    }
}

// for iOS lower than 13
extension _Colorable {
    @discardableResult
    public func color(_ color: UColor) -> Self {
        _setColor(color)
        return self
    }
}
