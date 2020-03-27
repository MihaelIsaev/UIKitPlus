import UIKit

public protocol TextFieldContentTypeable {
    func content(_ content: TextFieldContentType) -> Self
}

protocol _TextFieldContentTypeable: TextFieldContentTypeable {
    func _setTextFieldContentType(v: TextFieldContentType)
}

extension TextFieldContentTypeable {
    @discardableResult
    public func content(_ content: TextFieldContentType) -> Self {
        guard let s = self as? _TextFieldContentTypeable else { return self }
        s._setTextFieldContentType(v: content)
        return self
    }
}
