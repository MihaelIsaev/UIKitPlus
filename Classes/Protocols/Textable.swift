import UIKit

public protocol Textable: class {
    @discardableResult
    func textChangeTransition(_ value: UIView.AnimationOptions) -> Self
    
    @discardableResult
    func text(_ text: String) -> Self
    
    @discardableResult
    func text(_ state: State<String>) -> Self
    
    @discardableResult
    func text<V>(_ expressable: ExpressableState<V, String>) -> Self
    
    @discardableResult
    func text(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self
    
    // MARK: Attributed
    
    @discardableResult
    func attributedText(_ state: State<AttrStr>) -> Self
        
    @discardableResult
    func attributedText<V>(_ expressable: ExpressableState<V, AttrStr>) -> Self
    
    @discardableResult
    func attributedText(_ state: State<[AttrStr]>) -> Self
    
    @discardableResult
    func attributedText<V>(_ expressable: ExpressableState<V, [AttrStr]>) -> Self

    @discardableResult
    func attributedText(_ attributedStrings: AttributedString...) -> Self
    
    @discardableResult
    func attributedText(_ attributedStrings: [AttributedString]) -> Self

    @discardableResult
    func attributedText(@StateStringBuilder stateString: @escaping StateAttrStringBuilder.Handler) -> Self
}

protocol _Textable: Textable {
    var _stateString: StateStringBuilder.Handler? { get set }
    var _stateAttrString: StateAttrStringBuilder.Handler? { get set }
    var _textChangeTransition: UIView.AnimationOptions? { get set }
    
    func _setText(_ v: String?)
    func _setText(_ v: NSMutableAttributedString?)
}

extension _Textable {
    func _changeText(to newValue: String) {
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
    }
    
    func _changeText(to newValue: NSMutableAttributedString) {
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
    }
}

extension Textable {
    @discardableResult
    public func text<V>(_ expressable: ExpressableState<V, String>) -> Self {
        text(expressable.unwrap())
    }

    // MARK: Attributed
    
    @discardableResult
    public func attributedText<V>(_ expressable: ExpressableState<V, AttrStr>) -> Self {
        attributedText(expressable.unwrap())
    }
    
    @discardableResult
    public func attributedText<V>(_ expressable: ExpressableState<V, [AttrStr]>) -> Self {
        attributedText(expressable.unwrap())
    }
    

    @discardableResult
    public func attributedText(_ attributedStrings: AttributedString...) -> Self {
        attributedText(attributedStrings)
    }
}

@available(iOS 13.0, *)
extension Textable {
    @discardableResult
    public func textChangeTransition(_ value: UIView.AnimationOptions) -> Self {
        guard let s = self as? _Textable else { return self }
        s._textChangeTransition = value
        return self
    }
    
    @discardableResult
    public func text(_ text: String) -> Self {
        guard let s = self as? _Textable else { return self }
        s._changeText(to: text)
        return self
    }

    @discardableResult
    public func text(_ state: State<String>) -> Self {
        guard let s = self as? _Textable else { return self }
        s._changeText(to: state.wrappedValue)
        state.listen { s._changeText(to: $0) }
        if let s = self as? TextBindable {
            s.bind(state)
        }
        return self
    }
    
    @discardableResult
    public func text(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self {
        guard let s = self as? _Textable else { return self }
        s._stateString = stateString
        return text(stateString())
    }
    
    @discardableResult
    public func attributedText(_ state: State<AttrStr>) -> Self {
        guard let s = self as? _Textable else { return self }
        s._changeText(to: state.wrappedValue.attributedString)
        state.listen { s._changeText(to: $0.attributedString) }
        return self
    }
    
    @discardableResult
    public func attributedText(_ state: State<[AttrStr]>) -> Self {
        guard let s = self as? _Textable else { return self }
        s._changeText(to: state.wrappedValue.joined())
        state.listen { s._changeText(to: $0.joined()) }
        return self
    }
    
    @discardableResult
    public func attributedText(_ attributedStrings: [AttributedString]) -> Self {
        guard let s = self as? _Textable else { return self }
        s._changeText(to: attributedStrings.joined())
        return self
    }

    @discardableResult
    public func attributedText(@StateStringBuilder stateString: @escaping StateAttrStringBuilder.Handler) -> Self {
        guard let s = self as? _Textable else { return self }
        s._stateAttrString = stateString
        return attributedText(stateString())
    }
}

// for iOS lower than 13
extension _Textable {
    @discardableResult
    public func textChangeTransition(_ value: UIView.AnimationOptions) -> Self {
        _textChangeTransition = value
        return self
    }
    
    @discardableResult
    public func text(_ text: String) -> Self {
        _changeText(to: text)
        return self
    }

    @discardableResult
    public func text(_ state: State<String>) -> Self {
        _changeText(to: state.wrappedValue)
        state.listen { self._changeText(to: $0) }
        if let s = self as? TextBindable {
            s.bind(state)
        }
        return self
    }
    
    @discardableResult
    public func text(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self {
        _stateString = stateString
        return text(stateString())
    }
    
    @discardableResult
    public func attributedText(_ state: State<AttrStr>) -> Self {
        _changeText(to: state.wrappedValue.attributedString)
        state.listen { self._changeText(to: $0.attributedString) }
        return self
    }
    
    @discardableResult
    public func attributedText(_ state: State<[AttrStr]>) -> Self {
        _changeText(to: state.wrappedValue.joined())
        state.listen { self._changeText(to: $0.joined()) }
        return self
    }
    
    @discardableResult
    public func attributedText(_ attributedStrings: [AttributedString]) -> Self {
        _changeText(to: attributedStrings.joined())
        return self
    }

    @discardableResult
    public func attributedText(@StateStringBuilder stateString: @escaping StateAttrStringBuilder.Handler) -> Self {
        _stateAttrString = stateString
        return attributedText(stateString())
    }
}
