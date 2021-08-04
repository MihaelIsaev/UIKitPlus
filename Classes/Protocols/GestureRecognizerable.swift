#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol GestureRecognizerable: class {
    @discardableResult
    func delegate(_ v: UGestureRecognizerDelegate) -> Self
}

protocol _GestureRecognizerable: GestureRecognizerable {
    func _setDelegate(_ v: UGestureRecognizerDelegate)
    func _setEnabled(_ v: Bool)
    #if !os(macOS)
    func _setCancelsTouchesInView(_ v: Bool)
    func _setDelaysTouchesBegan(_ v: Bool)
    func _setDelaysTouchesEnded(_ v: Bool)
    func _setName(_ v: String)
    func _setRequiresExclusiveTouchType(_ v: Bool)
    func _setAllowedTouchTypes(_ v: [NSNumber])
    func _setAllowedPressTypes(_ v: [NSNumber])
    #endif
    func _setRequireToFailOtherGestureRecognizer(_ v: UGestureRecognizer)
}

@available(iOS 13.0, *)
extension GestureRecognizerable {
    @discardableResult
    public func delegate(_ v: UGestureRecognizerDelegate) -> Self {
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
    public func enabled(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.enabled($0)
        }
        return enabled(binding.wrappedValue)
    }
    
    #if !os(macOS)
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
    public func cancelsTouchesInView(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.cancelsTouchesInView($0)
        }
        return cancelsTouchesInView(binding.wrappedValue)
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
    public func delaysTouchesBegan(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.delaysTouchesBegan($0)
        }
        return delaysTouchesBegan(binding.wrappedValue)
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
    public func delaysTouchesEnded(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.delaysTouchesEnded($0)
        }
        return delaysTouchesEnded(binding.wrappedValue)
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
    public func requiresExclusiveTouchType(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.requiresExclusiveTouchType($0)
        }
        return requiresExclusiveTouchType(binding.wrappedValue)
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
    
    // MARK: debugName

    @discardableResult
    public func debugName(_ value: String) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setName(value)
        return self
    }
    #endif
    
    // MARK: require toFail
    
    @discardableResult
    public func require(toFail otherGestureRecognizer: UGestureRecognizer) -> Self {
        guard let s = self as? _GestureRecognizerable else { return self }
        s._setRequireToFailOtherGestureRecognizer(otherGestureRecognizer)
        return self
    }
}

// for iOS lower than 13
extension _GestureRecognizerable {
    @discardableResult
    public func delegate(_ v: UGestureRecognizerDelegate) -> Self {
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
    public func enabled(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.enabled($0)
        }
        return enabled(binding.wrappedValue)
    }
    
    #if !os(macOS)
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
    public func cancelsTouchesInView(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.cancelsTouchesInView($0)
        }
        return cancelsTouchesInView(binding.wrappedValue)
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
    public func delaysTouchesBegan(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.delaysTouchesBegan($0)
        }
        return delaysTouchesBegan(binding.wrappedValue)
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
    public func delaysTouchesEnded(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.delaysTouchesEnded($0)
        }
        return delaysTouchesEnded(binding.wrappedValue)
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
    public func requiresExclusiveTouchType(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { [weak self] in
            self?.requiresExclusiveTouchType($0)
        }
        return requiresExclusiveTouchType(binding.wrappedValue)
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
    
    // MARK: debugName

    @discardableResult
    public func debugName(_ value: String) -> Self {
        _setName(value)
        return self
    }
    #endif
    
    // MARK: require toFail
    
    @discardableResult
    public func require(toFail otherGestureRecognizer: UGestureRecognizer) -> Self {
        _setRequireToFailOtherGestureRecognizer(otherGestureRecognizer)
        return self
    }
}
