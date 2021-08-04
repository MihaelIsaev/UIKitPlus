#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Tintable: class {
    @discardableResult
    func tint(_ color: UColor) -> Self
    
    @discardableResult
    func tint(_ number: Int) -> Self
    
    @discardableResult
    func tint(_ color: State<UColor>) -> Self
}

protocol _Tintable: Tintable {
    var _tintState: State<UColor> { get }
    
    #if os(macOS)
    func _setTint(_ v: NSColor?)
    #else
    func _setTint(_ v: UColor?)
    #endif
}

extension Tintable {
    @discardableResult
    public func tint(_ number: Int) -> Self {
        tint(number.color)
    }
    
    @discardableResult
    public func tint(_ state: State<UColor>) -> Self {
        state.listen { [weak self] in
            self?.tint($0)
        }
        return tint(state.wrappedValue)
    }
}

@available(iOS 13.0, *)
extension Tintable {
    @discardableResult
    public func tint(_ color: UColor) -> Self {
        guard let s = self as? _Tintable else { return self }
        _tint(color, on: s)
        return self
    }
}

// for iOS lower than 13
extension _Tintable {
    @discardableResult
    public func tint(_ color: UColor) -> Self {
        _tint(color, on: self)
        return self
    }
}

private func  _tint(_ color: UColor, on s: _Tintable) {
    #if os(macOS)
    s._tintState.wrappedValue.changeHandler = nil
    #endif
    s._tintState.wrappedValue = color
    s._setTint(color.current)
    #if os(macOS)
    s._tintState.wrappedValue.onChange { [weak s] new in
        s?._setTint(new)
    }
    #endif
}
