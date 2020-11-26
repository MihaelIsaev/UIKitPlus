import UIKit

public protocol Enableable {
    @discardableResult
    func enabled() -> Self
    
    @discardableResult
    func enabled(_ value: Bool) -> Self
    
    @discardableResult
    func enabled(_ binding: UIKitPlus.UState<Bool>) -> Self
    
    @discardableResult
    func enabled<V>(_ expressable: ExpressableState<V, Bool>) -> Self
}

protocol _Enableable: Enableable {
    func _setEnabled(_ v: Bool)
}

extension Enableable {
    @discardableResult
    public func enabled() -> Self {
        enabled(true)
    }
    
    @discardableResult
    public func enabled(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.enabled($0) }
        return enabled(binding.wrappedValue)
    }
    
    @discardableResult
    public func enabled<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        enabled(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Enableable {
    @discardableResult
    public func enabled(_ value: Bool) -> Self {
        guard let s = self as? _Enableable else { return self }
        s._setEnabled(value)
        return self
    }
}

// for iOS lower than 13
extension _Enableable {
    @discardableResult
    public func enabled(_ value: Bool) -> Self {
        _setEnabled(value)
        return self
    }
}
