import UIKit

public protocol TextAutocorrectionable {
    @discardableResult
    func autocorrection(_ type: UITextAutocorrectionType) -> Self
}

protocol _TextAutocorrectionable: TextAutocorrectionable {
    func _setTextAutocorrectionType(_ v: UITextAutocorrectionType)
}

extension TextAutocorrectionable {
    @discardableResult
    public func autocorrection(_ type: UITextAutocorrectionType) -> Self {
        guard let  s = self as? _TextAutocorrectionable else { return self }
        s._setTextAutocorrectionType(type)
        return self
    }
}
