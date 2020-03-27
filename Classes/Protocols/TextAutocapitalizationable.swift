import UIKit

public protocol TextAutocapitalizationable {
    @discardableResult
    func autocapitalization(_ type: UITextAutocapitalizationType) -> Self
}

protocol _TextAutocapitalizationable: TextAutocapitalizationable {
    func _setTextAutocapitalizationType(_ v: UITextAutocapitalizationType)
}

extension TextAutocapitalizationable {
    @discardableResult
    public func autocapitalization(_ type: UITextAutocapitalizationType) -> Self {
        guard let s = self as? _TextAutocapitalizationable else { return self }
        s._setTextAutocapitalizationType(type)
        return self
    }
}
