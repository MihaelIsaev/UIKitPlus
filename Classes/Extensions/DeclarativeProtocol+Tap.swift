import UIKit

extension DeclarativeProtocol where V: UIView {
    @available(*, deprecated, renamed: "onTapGesture")
    @discardableResult
    public func tapAction(_ action: @escaping () -> Void) -> Self { onTapGesture(action) }
    
    @available(*, deprecated, renamed: "onTapGesture")
    @discardableResult
    public func tapAction(_ action: @escaping (Self) -> Void) -> Self { onTapGesture(action) }
    
    @discardableResult
    public func onTapGesture(count: Int = 1, _ action: @escaping () -> Void) -> Self {
        declarativeView.addGestureRecognizer(TapGestureRecognizer(count: count, action))
        return self
    }
    
    @discardableResult
    public func onTapGesture(count: Int = 1, _ action: @escaping (Self) -> Void) -> Self {
        let recognizer = TapGestureRecognizer(count: count) { [weak self] in
            guard let self = self else { return }
            action(self)
        }
        declarativeView.addGestureRecognizer(recognizer)
        return self
    }
}

extension DeclarativeProtocol where V: UIControl {
    @available(*, deprecated, renamed: "onTapGesture")
    @discardableResult
    public func tapAction(_ action: @escaping () -> Void, _ event: UIControl.Event = .touchUpInside) -> Self { onTapGesture(event, action) }
    
    @available(*, deprecated, renamed: "onTapGesture")
    @discardableResult
    public func tapAction(_ action: @escaping (V) -> Void, _ event: UIControl.Event = .touchUpInside) -> Self { onTapGesture(event, action) }
        
    @discardableResult
    public func onTapGesture(_ event: UIControl.Event = .touchUpInside, _ action: @escaping () -> Void) -> Self {
        declarativeView.actionHandler(controlEvents: event, forAction: action)
        return self
    }
    
    @discardableResult
    public func onTapGesture(_ event: UIControl.Event = .touchUpInside, _ action: @escaping (V) -> Void) -> Self {
        declarativeView.actionHandler(controlEvents: event) { [weak self] in
            guard let self = self as? V else { return }
            action(self)
        }
        return self
    }
}
