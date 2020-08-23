#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol ArrowPositionable {
    @discardableResult
    func arrowPosition(_ value: NSPopUpButton.ArrowPosition) -> Self
    
    @discardableResult
    func arrowPosition(_ binding: UIKitPlus.State<NSPopUpButton.ArrowPosition>) -> Self
    
    @discardableResult
    func arrowPosition<V>(_ expressable: ExpressableState<V, NSPopUpButton.ArrowPosition>) -> Self
}

protocol _ArrowPositionable: ArrowPositionable {
    func _setArrowPosition(_ v: NSPopUpButton.ArrowPosition)
}

extension ArrowPositionable {
    @discardableResult
    public func arrowPosition(_ binding: UIKitPlus.State<NSPopUpButton.ArrowPosition>) -> Self {
        binding.listen { self.arrowPosition($0) }
        return arrowPosition(binding.wrappedValue)
    }
    
    @discardableResult
    public func arrowPosition<V>(_ expressable: ExpressableState<V, NSPopUpButton.ArrowPosition>) -> Self {
        arrowPosition(expressable.unwrap())
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension ArrowPositionable {
    @discardableResult
    public func arrowPosition(_ value: NSPopUpButton.ArrowPosition) -> Self {
        guard let s = self as? _ArrowPositionable else { return self }
        s._setArrowPosition(value)
        return self
    }
}

// for iOS lower than 13
extension _ArrowPositionable {
    @discardableResult
    public func arrowPosition(_ value: NSPopUpButton.ArrowPosition) -> Self {
        _setArrowPosition(value)
        return self
    }
}
