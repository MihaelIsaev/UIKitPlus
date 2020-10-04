import UIKit

public protocol GestureRecognizerable {
    @discardableResult
    func delegate(_ v: UIGestureRecognizerDelegate) -> Self
}

protocol _GestureRecognizerable: GestureRecognizerable {
    func _setDelegate(_ v: UIGestureRecognizerDelegate)
    func _setEnabled(_ v: Bool)
    func _setCancelsTouchesInView(_ v: Bool)
    func _setDelaysTouchesBegan(_ v: Bool)
    func _setDelaysTouchesEnded(_ v: Bool)
    func _setName(_ v: String)
    func _setRequiresExclusiveTouchType(_ v: Bool)
    func _setAllowedTouchTypes(_ v: [NSNumber])
    func _setAllowedPressTypes(_ v: [NSNumber])
    func _setRequireToFailOtherGestureRecognizer(_ v: UIGestureRecognizer)
}

@available(iOS 13.0, *)
extension GestureRecognizerable {
    @discardableResult
    public func delegate(_ v: UIGestureRecognizerDelegate) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setDelegate(v)
        return self
    }
    
    // MARK: enabled
    
    @discardableResult
    public func enabled(_ value: Bool) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setEnabled(value)
        return self
    }
    
    @discardableResult
    public func enabled() -> Self {
        enabled(true)
    }
    
    @discardableResult
    public func enabled(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.enabled($0) }
        return enabled(binding.wrappedValue)
    }
    
    @discardableResult
    public func enabled<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        enabled(expressable.unwrap())
    }
    
    // MARK: cancelsTouchesInView
    
    @discardableResult
    public func cancelsTouchesInView(_ value: Bool) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setCancelsTouchesInView(value)
        return self
    }
    
    @discardableResult
    public func cancelsTouchesInView() -> Self {
        cancelsTouchesInView(true)
    }
    
    @discardableResult
    public func cancelsTouchesInView(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.cancelsTouchesInView($0) }
        return cancelsTouchesInView(binding.wrappedValue)
    }
    
    @discardableResult
    public func cancelsTouchesInView<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        cancelsTouchesInView(expressable.unwrap())
    }
    
    // MARK: delaysTouchesBegan
    
    @discardableResult
    public func delaysTouchesBegan(_ value: Bool) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setDelaysTouchesBegan(value)
        return self
    }
    
    @discardableResult
    public func delaysTouchesBegan() -> Self {
        delaysTouchesBegan(true)
    }
    
    @discardableResult
    public func delaysTouchesBegan(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.delaysTouchesBegan($0) }
        return delaysTouchesBegan(binding.wrappedValue)
    }
    
    @discardableResult
    public func delaysTouchesBegan<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        delaysTouchesBegan(expressable.unwrap())
    }
    
    // MARK: delaysTouchesEnded
    
    @discardableResult
    public func delaysTouchesEnded(_ value: Bool) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setDelaysTouchesEnded(value)
        return self
    }
    
    @discardableResult
    public func delaysTouchesEnded() -> Self {
        delaysTouchesEnded(true)
    }
    
    @discardableResult
    public func delaysTouchesEnded(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.delaysTouchesEnded($0) }
        return delaysTouchesEnded(binding.wrappedValue)
    }
    
    @discardableResult
    public func delaysTouchesEnded<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        delaysTouchesEnded(expressable.unwrap())
    }
    
    // MARK: requiresExclusiveTouchType
    
    @discardableResult
    public func requiresExclusiveTouchType(_ value: Bool) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setRequiresExclusiveTouchType(value)
        return self
    }
    
    @discardableResult
    public func requiresExclusiveTouchType() -> Self {
        requiresExclusiveTouchType(true)
    }
    
    @discardableResult
    public func requiresExclusiveTouchType(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.requiresExclusiveTouchType($0) }
        return requiresExclusiveTouchType(binding.wrappedValue)
    }
    
    @discardableResult
    public func requiresExclusiveTouchType<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        requiresExclusiveTouchType(expressable.unwrap())
    }
    
    // MARK: allowedTouchTypes
    
    @discardableResult
    public func allowedTouchTypes(_ values: [NSNumber]) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setAllowedTouchTypes(values)
        return self
    }
    
    @discardableResult
    public func allowedTouchTypes(_ values: NSNumber...) -> Self {
        allowedTouchTypes(values)
    }

    @discardableResult
    public func allowedPressTypes(_ values: NSNumber...) -> Self {
        allowedPressTypes(values)
    }
    
    // MARK: allowedPressTypes
    
    @discardableResult
    public func allowedPressTypes(_ values: [NSNumber]) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setAllowedPressTypes(values)
        return self
    }
    
    // MARK: require toFail
    
    @discardableResult
    public func require(toFail otherGestureRecognizer: UIGestureRecognizer) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setRequireToFailOtherGestureRecognizer(otherGestureRecognizer)
        return self
    }
    
    // MARK: debugName

    @discardableResult
    public func debugName(_ value: String) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setName(value)
        return self
    }
}

// for iOS lower than 13
extension _GestureRecognizerable {
    @discardableResult
    public func delegate(_ v: UIGestureRecognizerDelegate) -> Self {
        _setDelegate(v)
        return self
    }
    
    // MARK: enabled
    
    @discardableResult
    public func enabled(_ value: Bool) -> Self {
        _setEnabled(value)
        return self
    }
    
    @discardableResult
    public func enabled() -> Self {
        enabled(true)
    }
    
    @discardableResult
    public func enabled(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.enabled($0) }
        return enabled(binding.wrappedValue)
    }
    
    @discardableResult
    public func enabled<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        enabled(expressable.unwrap())
    }
    
    // MARK: cancelsTouchesInView
    
    @discardableResult
    public func cancelsTouchesInView(_ value: Bool) -> Self {
        _setCancelsTouchesInView(value)
        return self
    }
    
    @discardableResult
    public func cancelsTouchesInView() -> Self {
        cancelsTouchesInView(true)
    }
    
    @discardableResult
    public func cancelsTouchesInView(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.cancelsTouchesInView($0) }
        return cancelsTouchesInView(binding.wrappedValue)
    }
    
    @discardableResult
    public func cancelsTouchesInView<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        cancelsTouchesInView(expressable.unwrap())
    }
    
    // MARK: delaysTouchesBegan
    
    @discardableResult
    public func delaysTouchesBegan(_ value: Bool) -> Self {
        _setDelaysTouchesBegan(value)
        return self
    }
    
    @discardableResult
    public func delaysTouchesBegan() -> Self {
        delaysTouchesBegan(true)
    }
    
    @discardableResult
    public func delaysTouchesBegan(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.delaysTouchesBegan($0) }
        return delaysTouchesBegan(binding.wrappedValue)
    }
    
    @discardableResult
    public func delaysTouchesBegan<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        delaysTouchesBegan(expressable.unwrap())
    }
    
    // MARK: delaysTouchesEnded
    
    @discardableResult
    public func delaysTouchesEnded(_ value: Bool) -> Self {
        _setDelaysTouchesEnded(value)
        return self
    }
    
    @discardableResult
    public func delaysTouchesEnded() -> Self {
        delaysTouchesEnded(true)
    }
    
    @discardableResult
    public func delaysTouchesEnded(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.delaysTouchesEnded($0) }
        return delaysTouchesEnded(binding.wrappedValue)
    }
    
    @discardableResult
    public func delaysTouchesEnded<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        delaysTouchesEnded(expressable.unwrap())
    }
    
    // MARK: requiresExclusiveTouchType
    
    @discardableResult
    public func requiresExclusiveTouchType(_ value: Bool) -> Self {
        _setRequiresExclusiveTouchType(value)
        return self
    }
    
    @discardableResult
    public func requiresExclusiveTouchType() -> Self {
        requiresExclusiveTouchType(true)
    }
    
    @discardableResult
    public func requiresExclusiveTouchType(_ binding: UIKitPlus.UState<Bool>) -> Self {
        binding.listen { self.requiresExclusiveTouchType($0) }
        return requiresExclusiveTouchType(binding.wrappedValue)
    }
    
    @discardableResult
    public func requiresExclusiveTouchType<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        requiresExclusiveTouchType(expressable.unwrap())
    }
    
    // MARK: allowedTouchTypes
    
    @discardableResult
    public func allowedTouchTypes(_ values: [NSNumber]) -> Self {
        _setAllowedTouchTypes(values)
        return self
    }
    
    @discardableResult
    public func allowedTouchTypes(_ values: NSNumber...) -> Self {
        allowedTouchTypes(values)
    }

    @discardableResult
    public func allowedPressTypes(_ values: NSNumber...) -> Self {
        allowedPressTypes(values)
    }
    
    // MARK: allowedPressTypes
    
    @discardableResult
    public func allowedPressTypes(_ values: [NSNumber]) -> Self {
        _setAllowedPressTypes(values)
        return self
    }
    
    // MARK: require toFail
    
    @discardableResult
    public func require(toFail otherGestureRecognizer: UIGestureRecognizer) -> Self {
        _setRequireToFailOtherGestureRecognizer(otherGestureRecognizer)
        return self
    }
    
    // MARK: debugName

    @discardableResult
    public func debugName(_ value: String) -> Self {
        _setName(value)
        return self
    }
}
