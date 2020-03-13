import UIKit

public protocol TextLineBreakModeable {
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> Self
}

protocol _TextLineBreakModeable: TextLineBreakModeable {
    func _setLineBreakMode(_ v: NSLineBreakMode)
}

extension TextLineBreakModeable {
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        guard let s = self as? _TextLineBreakModeable else { return self }
        s._setLineBreakMode(mode)
        return self
    }
}
