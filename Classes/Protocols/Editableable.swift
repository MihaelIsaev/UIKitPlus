#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Editableable: class {
    @discardableResult
    func editable() -> Self
    
    @discardableResult
    func editable(_ value: Bool) -> Self
    
    @discardableResult
    func editable(_ binding: UIKitPlus.State<Bool>) -> Self
    
    @discardableResult
    func editable<V>(_ expressable: ExpressableState<V, Bool>) -> Self
}

protocol _Editableable: Editableable {
    func _setEditable(_ v: Bool)
}

extension Editableable {
    @discardableResult
    public func editable() -> Self {
        editable(true)
    }
    
    @discardableResult
    public func editable(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.editable($0)
        }
        return editable(binding.wrappedValue)
    }
    
    @discardableResult
    public func editable<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        editable(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Editableable {
    @discardableResult
    public func editable(_ value: Bool) -> Self {
        guard let s = self as? _Editableable else { return self }
        s._setEditable(value)
        return self
    }
}

// for iOS lower than 13
extension _Editableable {
    @discardableResult
    public func editable(_ value: Bool) -> Self {
        _setEditable(value)
        return self
    }
}
