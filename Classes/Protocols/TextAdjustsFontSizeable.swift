import UIKit

public protocol TextAdjustsFontSizeable {
    @discardableResult
    func adjustsFontSizeToFitWidth() -> Self
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ value: Bool) -> Self
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ binding: UIKitPlus.UState<Bool>) -> Self
    
    @discardableResult
    func adjustsFontSizeToFitWidth<V>(_ expressable: ExpressableState<V, Bool>) -> Self
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
    public func adjustsFontSizeToFitWidth(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.adjustsFontSizeToFitWidth($0) }
        return adjustsFontSizeToFitWidth(binding.wrappedValue)
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        adjustsFontSizeToFitWidth(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension TextAdjustsFontSizeable {
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool) -> Self {
        guard let s = self as? _TextAdjustsFontSizeable else { return self }
        s._setAdjustsFontSizeToFitWidth(value)
        return self
    }
}

// for iOS lower than 13s
extension _TextAdjustsFontSizeable {
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool) -> Self {
        _setAdjustsFontSizeToFitWidth(value)
        return self
    }
}
