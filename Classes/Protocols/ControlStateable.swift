#if os(macOS)
import Cocoa

public protocol ControlStateable: class {
    @discardableResult
    func state(_ value: NSControl.StateValue) -> Self
    
    @discardableResult
    func state(_ binding: UIKitPlus.State<NSControl.StateValue>) -> Self
    
    @discardableResult
    func state<V>(_ expressable: ExpressableState<V, NSControl.StateValue>) -> Self
}

protocol _ControlStateable: ControlStateable {
    var _stateState: State<NSControl.StateValue> { get set }
    
    func _setState(_ v: NSControl.StateValue)
}

extension ControlStateable {
    @discardableResult
    public func state<V>(_ expressable: ExpressableState<V, NSControl.StateValue>) -> Self {
        state(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension ControlStateable {
    @discardableResult
    public func state(_ binding: UIKitPlus.State<NSControl.StateValue>) -> Self {
        guard var s = self as? _ControlStateable else { return self }
        s._stateState = binding
        s._setState(binding.wrappedValue)
        binding.listen { [weak self] in s?._setState($0) }
        return self
    }
    
    @discardableResult
    public func state(_ value: NSControl.StateValue) -> Self {
        guard let s = self as? _ControlStateable else { return self }
        s._stateState.wrappedValue = value
        s._setState(value)
        return self
    }
}

// for iOS lower than 13
extension _ControlStateable {
    @discardableResult
    public func state(_ binding: UIKitPlus.State<NSControl.StateValue>) -> Self {
        _stateState = binding
        _setState(binding.wrappedValue)
        binding.listen { [weak self] in self?._setState($0) }
        return self
    }
    
    @discardableResult
    public func state(_ value: NSControl.StateValue) -> Self {
        _stateState.wrappedValue = value
        _setState(value)
        return self
    }
}
#endif
