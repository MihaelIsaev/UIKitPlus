#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Tintable {
    @discardableResult
    func tint(_ color: UColor) -> Self
    
    @discardableResult
    func tint(_ number: Int) -> Self
    
    @discardableResult
    func tint(_ color: State<UColor>) -> Self
    
    @discardableResult
    func tint<V>(_ expressable: ExpressableState<V, UColor>) -> Self
}

protocol _Tintable: Tintable {
    var _tintState: State<UColor> { get }
    
    func _setTint(_ v: UColor?)
}

extension Tintable {
    @discardableResult
    public func tint(_ number: Int) -> Self {
        tint(number.color)
    }
    
    @discardableResult
    public func tint(_ state: State<UColor>) -> Self {
        state.listen { self.tint($0) }
        return tint(state.wrappedValue)
    }
    
    @discardableResult
    public func tint<V>(_ expressable: ExpressableState<V, UColor>) -> Self {
        tint(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Tintable {
    @discardableResult
    public func tint(_ color: UColor) -> Self {
        guard let s = self as? _Tintable else { return self }
        s._setTint(color)
        return self
    }
}

// for iOS lower than 13
extension _Tintable {
    @discardableResult
    public func tint(_ color: UColor) -> Self {
        _setTint(color)
        return self
    }
}
