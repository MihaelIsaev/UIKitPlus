import UIKit

public protocol TextScaleable {
    @discardableResult
    func minimumScaleFactor(_ value: CGFloat) -> Self
}

protocol _TextScaleable: TextScaleable {
    func _setMinimumScaleFactor(_ v: CGFloat)
}

extension TextScaleable {
    @discardableResult
    public func minimumScaleFactor(_ value: CGFloat) -> Self {
        guard let s = self as? _TextScaleable else { return self }
        s._setMinimumScaleFactor(value)
        return self
    }
}
