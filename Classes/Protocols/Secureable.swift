import UIKit

public protocol Secureable {
    @discardableResult
    func secure() -> Self
    
    @discardableResult
    func secure(_ value: Bool) -> Self
    
    @discardableResult
    func secure(_ binding: UIKitPlus.State<Bool>) -> Self
    
    @discardableResult
    func secure<V>(_ expressable: ExpressableState<V, Bool>) -> Self
}

protocol _Secureable: Secureable {
    func _setSecure(_ v: Bool)
}

extension Secureable {
    @discardableResult
    public func secure() -> Self {
        secure(true)
    }
    
    @discardableResult
    public func secure(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { self.secure($0) }
        return secure(binding.wrappedValue)
    }
    
    @discardableResult
    public func secure<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        secure(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Secureable {
    @discardableResult
    public func secure(_ value: Bool) -> Self {
        guard let s = self as? _Secureable else { return self }
        s._setSecure(value)
        return self
    }
}

// for iOS lower than 13
extension _Secureable {
    @discardableResult
    public func secure(_ value: Bool) -> Self {
        _setSecure(value)
        return self
    }
}
