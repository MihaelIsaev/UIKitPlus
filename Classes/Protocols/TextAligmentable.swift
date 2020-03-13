import UIKit

public protocol TextAligmentable {
    func alignment(_ alignment: NSTextAlignment) -> Self
}

protocol _TextAligmentable: TextAligmentable {
    func _setTextAlignment(v: NSTextAlignment)
}

extension TextAligmentable {
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        guard let s = self as? _TextAligmentable else { return self }
        s._setTextAlignment(v: alignment)
        return self
    }
}
