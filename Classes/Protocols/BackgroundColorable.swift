#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol BackgroundColorable: class {
    @discardableResult
    func background(_ color: UColor) -> Self
    
    @discardableResult
    func background(_ number: Int) -> Self
    
    @discardableResult
    func background(_ color: State<UColor>) -> Self
    
    @discardableResult
    func background<V>(_ expressable: ExpressableState<V, UColor>) -> Self
}

protocol _BackgroundColorable: BackgroundColorable {
    var _backgroundColorState: State<UColor> { get }
    
    #if os(macOS)
    func _setBackgroundColor(_ v: NSColor?)
    #else
    func _setBackgroundColor(_ v: UColor?)
    #endif
}

extension BackgroundColorable {
    @discardableResult
    public func background(_ number: Int) -> Self {
        background(number.color)
    }
    
    @discardableResult
    public func background(_ state: State<UColor>) -> Self {
        state.listen { [weak self] in self?.background($0) }
        return background(state.wrappedValue)
    }
    
    @discardableResult
    public func background<V>(_ expressable: ExpressableState<V, UColor>) -> Self {
        background(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension BackgroundColorable {
    @discardableResult
    public func background(_ color: UColor) -> Self {
        guard let s = self as? _BackgroundColorable else { return self }
        _background(color, on: s)
        return self
    }
}

// for iOS lower than 13
extension _BackgroundColorable {
    @discardableResult
    public func background(_ color: UColor) -> Self {
        _background(color, on: self)
        return self
    }
}

private func  _background(_ color: UColor, on s: _BackgroundColorable) {
    #if os(macOS)
    s._backgroundColorState.wrappedValue.changeHandler = nil
    #endif
    s._backgroundColorState.wrappedValue = color
    s._setBackgroundColor(color.current)
    #if os(macOS)
    s._backgroundColorState.wrappedValue.onChange { [weak s] new in
        s?._setBackgroundColor(new)
    }
    #endif
}
