import UIKit

public protocol Placeholderable {
    @discardableResult
    func placeholder(_ text: String?) -> Self
    
    @discardableResult
    func placeholder(_ binding: UIKitPlus.State<String>) -> Self
    
    @discardableResult
    func placeholder<V>(_ expressable: ExpressableState<V, String>) -> Self
    
    @discardableResult
    func placeholder(_ attributedStrings: AttributedString...) -> Self
}

protocol _Placeholderable: Placeholderable {
    func _setPlaceholder(_ v: String)
    func _setPlaceholder(_ v: AttrStr?)
}

extension Placeholderable {
    @discardableResult
    public func placeholder(_ localized: LocalizedString...) -> Self {
        placeholder(String(localized))
    }
    
    @discardableResult
    public func placeholder(_ localized: [LocalizedString]) -> Self {
        placeholder(String(localized))
    }
    
    @discardableResult
    public func placeholder(_ binding: UIKitPlus.State<String>) -> Self {
        binding.listen { self.placeholder($0) }
        return placeholder(binding.wrappedValue)
    }
    
    @discardableResult
    public func placeholder<V>(_ expressable: ExpressableState<V, String>) -> Self {
        placeholder(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Placeholderable {
    @discardableResult
    public func placeholder(_ text: String?) -> Self {
        guard let s = self as? _Placeholderable else { return self }
        s._setPlaceholder(text ?? "")
        return self
    }
    
    @discardableResult
    public func placeholder(_ attributedStrings: AttributedString...) -> Self {
        guard let s = self as? _Placeholderable else { return self }
        guard !attributedStrings.isEmpty else {
            s._setPlaceholder(nil)
            return self
        }
        s._setPlaceholder(attributedStrings.joined())
        return self
    }
}

// for iOS lower than 13
extension _Placeholderable {
    @discardableResult
    public func placeholder(_ text: String?) -> Self {
        _setPlaceholder(text ?? "")
        return self
    }
    
    @discardableResult
    public func placeholder(_ attributedStrings: AttributedString...) -> Self {
        guard !attributedStrings.isEmpty else {
            _setPlaceholder(nil)
            return self
        }
        _setPlaceholder(attributedStrings.joined())
        return self
    }
}
