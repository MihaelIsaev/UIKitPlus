#if os(macOS)
import AppKit

public protocol Soundable: class {
    @discardableResult
    func sound(_ value: NSSound?) -> Self
    
    @discardableResult
    func sound(_ binding: UIKitPlus.State<NSSound?>) -> Self
}

protocol _Soundable: Soundable {
    func _setSound(_ v: NSSound?)
}

extension Soundable {
    @discardableResult
    public func sound(_ binding: UIKitPlus.State<NSSound?>) -> Self {
        binding.listen { [weak self] in
            self?.sound($0)
        }
        return sound(binding.wrappedValue)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension Soundable {
    @discardableResult
    public func sound(_ value: NSSound?) -> Self {
        guard let s = self as? _Soundable else { return self }
        s._setSound(value)
        return self
    }
}

// for iOS lower than 13
extension _Soundable {
    @discardableResult
    public func sound(_ value: NSSound?) -> Self {
        _setSound(value)
        return self
    }
}
#endif
