#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol MultiClickIgnorable: class {
    @discardableResult
    func ignoreMultiClick() -> Self
    
    @discardableResult
    func ignoreMultiClick(_ value: Bool) -> Self
    
    @discardableResult
    func ignoreMultiClick(_ binding: UIKitPlus.State<Bool>) -> Self
}

protocol _MultiClickIgnorable: MultiClickIgnorable {
    var _ignoreMultiClickState: State<Bool> { get }
    
    func _setIgnoreMultiClick(_ v: Bool)
}

extension MultiClickIgnorable {
    @discardableResult
    public func ignoreMultiClick() -> Self {
        ignoreMultiClick(true)
    }
    
    @discardableResult
    public func ignoreMultiClick(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.ignoreMultiClick($0)
        }
        return ignoreMultiClick(binding.wrappedValue)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension MultiClickIgnorable {
    @discardableResult
    public func ignoreMultiClick(_ value: Bool) -> Self {
        guard let s = self as? _MultiClickIgnorable else { return self }
        s._setIgnoreMultiClick(value)
        return self
    }
}

// for iOS lower than 13
extension _MultiClickIgnorable {
    @discardableResult
    public func ignoreMultiClick(_ value: Bool) -> Self {
        _setIgnoreMultiClick(value)
        return self
    }
}
