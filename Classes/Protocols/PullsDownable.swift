#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol PullsDownable: class {
    @discardableResult
    func pullsDown() -> Self
    
    @discardableResult
    func pullsDown(_ value: Bool) -> Self
    
    @discardableResult
    func pullsDown(_ binding: UIKitPlus.State<Bool>) -> Self
}

protocol _PullsDownable: PullsDownable {
    func _setPullsDown(_ v: Bool)
}

extension PullsDownable {
    @discardableResult
    public func pullsDown() -> Self {
        pullsDown(true)
    }
    
    @discardableResult
    public func pullsDown(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.pullsDown($0)
        }
        return pullsDown(binding.wrappedValue)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension PullsDownable {
    @discardableResult
    public func pullsDown(_ value: Bool) -> Self {
        guard let s = self as? _PullsDownable else { return self }
        s._setPullsDown(value)
        return self
    }
}

// for iOS lower than 13
extension _PullsDownable {
    @discardableResult
    public func pullsDown(_ value: Bool) -> Self {
        _setPullsDown(value)
        return self
    }
}
