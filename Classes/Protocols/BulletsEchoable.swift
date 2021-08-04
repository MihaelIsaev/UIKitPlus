#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol BulletsEchoable {
    @discardableResult
    func echosBullets() -> Self
    
    @discardableResult
    func echosBullets(_ value: Bool) -> Self
    
    @discardableResult
    func echosBullets(_ binding: UIKitPlus.State<Bool>) -> Self
}

protocol _BulletsEchoable: BulletsEchoable {
    func _setEchosBullets(_ v: Bool)
}

extension BulletsEchoable {
    @discardableResult
    public func echosBullets() -> Self {
        echosBullets(true)
    }
    
    @discardableResult
    public func echosBullets(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { self.echosBullets($0) }
        return echosBullets(binding.wrappedValue)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension BulletsEchoable {
    @discardableResult
    public func echosBullets(_ value: Bool) -> Self {
        guard let s = self as? _BulletsEchoable else { return self }
        s._setEchosBullets(value)
        return self
    }
}

// for iOS lower than 13
extension _BulletsEchoable {
    @discardableResult
    public func echosBullets(_ value: Bool) -> Self {
        _setEchosBullets(value)
        return self
    }
}

