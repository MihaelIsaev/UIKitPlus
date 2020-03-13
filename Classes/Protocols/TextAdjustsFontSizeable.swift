import UIKit

public protocol TextAdjustsFontSizeable {
    @discardableResult
    func adjustsFontSizeToFitWidth() -> Self
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ value: Bool) -> Self
}

protocol _TextAdjustsFontSizeable: TextAdjustsFontSizeable {
    func _setAdjustsFontSizeToFitWidth(_ v: Bool)
}

extension TextAdjustsFontSizeable {
    @discardableResult
    public func adjustsFontSizeToFitWidth() -> Self {
        adjustsFontSizeToFitWidth(true)
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool) -> Self {
        guard let s = self as? _TextAdjustsFontSizeable else { return self }
        s._setAdjustsFontSizeToFitWidth(value)
        return self
    }
}
