#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol TextLineBreakModeable {
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> Self
}

protocol _TextLineBreakModeable: TextLineBreakModeable {
    func _setLineBreakMode(_ v: NSLineBreakMode)
}

@available(iOS 13.0, *)
extension TextLineBreakModeable {
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        guard let s = self as? _TextLineBreakModeable else { return self }
        s._setLineBreakMode(mode)
        return self
    }
}

// for iOS lower than 13
extension _TextLineBreakModeable {
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        _setLineBreakMode(mode)
        return self
    }
}
