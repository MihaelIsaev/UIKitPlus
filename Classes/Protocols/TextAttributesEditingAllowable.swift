#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol TextAttributesEditingAllowable: class {
    @discardableResult
    func allowEditingTextAttributes() -> Self
    
    @discardableResult
    func allowEditingTextAttributes(_ value: Bool) -> Self
    
    @discardableResult
    func allowEditingTextAttributes(_ binding: UIKitPlus.State<Bool>) -> Self
}

protocol _TextAttributesEditingAllowable: TextAttributesEditingAllowable {
    func _setAllowEditingTextAttributes(_ v: Bool)
}

extension TextAttributesEditingAllowable {
    @discardableResult
    public func allowEditingTextAttributes() -> Self {
        allowEditingTextAttributes(true)
    }
    
    @discardableResult
    public func allowEditingTextAttributes(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.allowEditingTextAttributes($0)
        }
        return allowEditingTextAttributes(binding.wrappedValue)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension TextAttributesEditingAllowable {
    @discardableResult
    public func allowEditingTextAttributes(_ value: Bool) -> Self {
        guard let s = self as? _TextAttributesEditingAllowable else { return self }
        s._setAllowEditingTextAttributes(value)
        return self
    }
}

// for iOS lower than 13
extension _TextAttributesEditingAllowable {
    @discardableResult
    public func allowEditingTextAttributes(_ value: Bool) -> Self {
        _setAllowEditingTextAttributes(value)
        return self
    }
}
