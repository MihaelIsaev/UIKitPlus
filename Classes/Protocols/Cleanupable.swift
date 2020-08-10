#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Cleanupable {
    @discardableResult
    func cleanup() -> Self
}

protocol _Cleanupable: Cleanupable {
    func _cleanup()
}

@available(iOS 13.0, *)
extension Cleanupable {
    @discardableResult
    public func cleanup() -> Self {
        guard let s = self as? _Cleanupable else { return self }
        s._cleanup()
        return self
    }
}

// for iOS lower than 13
extension _Cleanupable {
    @discardableResult
    public func cleanup() -> Self {
        _cleanup()
        return self
    }
}
