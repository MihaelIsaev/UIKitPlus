#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Secureable: class {
    @discardableResult
    func secure() -> Self
    
    @discardableResult
    func secure(_ value: Bool) -> Self
    
    @discardableResult
    func secure(_ binding: UIKitPlus.State<Bool>) -> Self
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
        binding.listen { [weak self] in
            self?.secure($0)
        }
        return secure(binding.wrappedValue)
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
