#if os(macOS)
import Cocoa

public protocol BezelStyleable: class {
    @discardableResult
    func style(_ value: NSButton.BezelStyle) -> Self
    
    @discardableResult
    func style(_ binding: UIKitPlus.State<NSButton.BezelStyle>) -> Self
    
    @discardableResult
    func style<V>(_ expressable: ExpressableState<V, NSButton.BezelStyle>) -> Self
}

protocol _BezelStyleable: BezelStyleable {
    var _bezelStyleState: State<NSButton.BezelStyle> { get set }
    
    func _setBezelStyle(_ v: NSButton.BezelStyle)
}

extension BezelStyleable {
    @discardableResult
    public func style<V>(_ expressable: ExpressableState<V, NSButton.BezelStyle>) -> Self {
        style(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension BezelStyleable {
    @discardableResult
    public func style(_ binding: UIKitPlus.State<NSButton.BezelStyle>) -> Self {
        guard var s = self as? _BezelStyleable else { return self }
        s._bezelStyleState = binding
        s._setBezelStyle(binding.wrappedValue)
        binding.listen { s._setBezelStyle($0) }
        return self
    }
    
    @discardableResult
    public func style(_ value: NSButton.BezelStyle) -> Self {
        guard let s = self as? _BezelStyleable else { return self }
        s._bezelStyleState.wrappedValue = value
        s._setBezelStyle(value)
        return self
    }
}

// for iOS lower than 13
extension _BezelStyleable {
    @discardableResult
    public func style(_ binding: UIKitPlus.State<NSButton.BezelStyle>) -> Self {
        _bezelStyleState = binding
        _setBezelStyle(binding.wrappedValue)
        binding.listen { self._setBezelStyle($0) }
        return self
    }
    
    @discardableResult
    public func style(_ value: NSButton.BezelStyle) -> Self {
        _bezelStyleState.wrappedValue = value
        _setBezelStyle(value)
        return self
    }
}
#endif
