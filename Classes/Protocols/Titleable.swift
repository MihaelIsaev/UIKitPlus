#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Titleable: class {
    @discardableResult
    func title(_ text: String) -> Self
    
    @discardableResult
    func title(_ state: State<String>) -> Self
    
    @discardableResult
    func title<V>(_ expressable: ExpressableState<V, String>) -> Self
    
    @discardableResult
    func title(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self
}

protocol _Titleable: Titleable {
    func _setTitle(_ v: String?)
}

extension Titleable {
    @discardableResult
    public func title(_ localized: LocalizedString...) -> Self {
        title(String(localized))
    }
    
    @discardableResult
    public func title(_ localized: [LocalizedString]) -> Self {
        title(String(localized))
    }
    
    @discardableResult
    public func title<V>(_ expressable: ExpressableState<V, String>) -> Self {
        title(expressable.unwrap())
    }

    @discardableResult
    public func title(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self {
        title(stateString())
    }
}

@available(iOS 13.0, *)
extension Titleable {
    @discardableResult
    public func title(_ text: String) -> Self {
        guard let s = self as? _Titleable else { return self }
        s._setTitle(text)
        return self
    }

    @discardableResult
    public func title(_ state: State<String>) -> Self {
        guard let s = self as? _Titleable else { return self }
        s._setTitle(state.wrappedValue)
        state.listen { s._setTitle($0) }
        return self
    }
}

// for iOS lower than 13
extension _Titleable {
    @discardableResult
    public func title(_ text: String) -> Self {
        _setTitle(text)
        return self
    }

    @discardableResult
    public func title(_ state: State<String>) -> Self {
        _setTitle(state.wrappedValue)
        state.listen { self._setTitle($0) }
        return self
    }
}
