import UIKit

extension DeclarativeProtocol where V: UIView {
    @discardableResult
    public func tapAction(_ action: @escaping () -> Void) -> Self {
        declarativeView.addGestureRecognizer(TapGestureRecognizer(action))
        return self
    }
    
    @discardableResult
    public func tapAction(_ action: @escaping (V) -> Void) -> Self {
        let recognizer = TapGestureRecognizer { [weak self] in
            guard let self = self as? V else { return }
            action(self)
        }
        declarativeView.addGestureRecognizer(recognizer)
        return self
    }
}

extension DeclarativeProtocol where V: UIControl {
    @discardableResult
    public func tapAction(_ action: @escaping () -> Void, _ event: UIControl.Event = .touchUpInside) -> Self {
        declarativeView.actionHandler(controlEvents: event, forAction: action)
        return self
    }
    
    @discardableResult
    public func tapAction(_ action: @escaping (V) -> Void, _ event: UIControl.Event = .touchUpInside) -> Self {
        declarativeView.actionHandler(controlEvents: event) { [weak self] in
            guard let self = self as? V else { return }
            action(self)
        }
        return self
    }
}
