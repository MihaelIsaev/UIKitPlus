#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Hiddenable {
    @discardableResult
    func hidden() -> Self
    
    @discardableResult
    func hidden(_ value: Bool) -> Self
    
    @discardableResult
    func hidden(_ binding: UIKitPlus.State<Bool>) -> Self
}

protocol _Hiddenable: Hiddenable {
    var _hiddenState: State<Bool> { get }
    
    func _setHidden(_ v: Bool)
}

extension Hiddenable {
    @discardableResult
    public func hidden() -> Self {
        hidden(true)
    }
    
    @discardableResult
    public func hidden(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { self.hidden($0) }
        return hidden(binding.wrappedValue)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension Hiddenable {
    @discardableResult
    public func hidden(_ value: Bool) -> Self {
        guard let s = self as? _Hiddenable else { return self }
        s._setHidden(value)
        return self
    }
}

// for iOS lower than 13
extension _Hiddenable {
    @discardableResult
    public func hidden(_ value: Bool) -> Self {
        _setHidden(value)
        return self
    }
}
