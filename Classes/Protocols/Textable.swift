#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Textable: class {
    #if !os(macOS)
    @discardableResult
    func textChangeTransition(_ value: UIView.AnimationOptions) -> Self
    #endif
    
    @discardableResult
    func text(_ value: LocalizedString...) -> Self
    
    @discardableResult
    func text(_ value: [LocalizedString]) -> Self
    
    @discardableResult
    func text(_ value: AnyString...) -> Self
    
    @discardableResult
    func text(_ value: [AnyString]) -> Self
    
    @discardableResult
    func text<V: AnyString>(_ state: State<V>) -> Self
    
    @discardableResult
    func text(@AnyStringBuilder stateString: @escaping AnyStringBuilder.Handler) -> Self
}

protocol _Textable: Textable {
    var _statedText: AnyStringBuilder.Handler? { get set }
    #if !os(macOS)
    var _textChangeTransition: UIView.AnimationOptions? { get set }
    #endif
    
    func _setText(_ v: NSAttributedString?)
}

extension _Textable {
    func _changeText(to newValue: NSAttributedString) {
        #if os(macOS)
        _setText(newValue)
        #else
        guard let transition = _textChangeTransition else {
            _setText(newValue)
            return
        }
        if let view = self as? _ViewTransitionable {
            view._transition(0.25, transition) {
                self._setText(newValue)
            }
        } else {
            _setText(newValue)
        }
        #endif
    }
}

extension Textable {
    @discardableResult
    public func text(_ value: LocalizedString...) -> Self {
        text(String(value))
    }
    
    @discardableResult
    public func text(_ value: [LocalizedString]) -> Self {
        text(String(value))
    }
    
    @discardableResult
    public func text(_ value: AnyString...) -> Self {
        text(value)
    }

    @discardableResult
    public func text<A: AnyString>(_ state: State<A>) -> Self {
        text(state.wrappedValue)
        state.listen { [weak self] in
            self?.text($0)
        }
        (self as? TextBindable)?.bind(state)
        return self
    }
}

@available(iOS 13.0, *)
extension Textable {
    #if !os(macOS)
    @discardableResult
    public func textChangeTransition(_ value: UIView.AnimationOptions) -> Self {
        guard let s = self as? _Textable else { return self }
        s._textChangeTransition = value
        return self
    }
    #endif
    
    @discardableResult
    public func text(_ value: [AnyString]) -> Self {
        guard let s = self as? _Textable else { return self }
        value.onUpdate { [weak s] in
            s?._changeText(to: $0)
        }
        s._changeText(to: value.attributedString)
        return self
    }
    
    @discardableResult
    public func text(@AnyStringBuilder stateString: @escaping AnyStringBuilder.Handler) -> Self {
        (self as? _Textable)?._statedText = stateString
        return text(stateString())
    }
}

// for iOS lower than 13
extension _Textable {
    #if !os(macOS)
    @discardableResult
    public func textChangeTransition(_ value: UIView.AnimationOptions) -> Self {
        _textChangeTransition = value
        return self
    }
    #endif
    
    @discardableResult
    public func text(_ value: [AnyString]) -> Self {
        value.onUpdate { [weak self] in
            self?._changeText(to: $0)
        }
        _changeText(to: value.attributedString)
        return self
    }
    
    @discardableResult
    public func text(@AnyStringBuilder stateString: @escaping AnyStringBuilder.Handler) -> Self {
        _statedText = stateString
        return text(stateString())
    }
}
