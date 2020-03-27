import UIKit

public protocol Cleanupable {
    @discardableResult
    func cleanup() -> Self
}

protocol _Cleanupable: Cleanupable {
    func _cleanup()
}

extension Cleanupable {
    @discardableResult
    public func cleanup() -> Self {
        guard let s = self as? _Cleanupable else { return self }
        s._cleanup()
        return self
    }
}
