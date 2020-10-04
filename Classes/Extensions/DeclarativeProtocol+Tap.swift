import UIKit

extension DeclarativeProtocol where V: UIView {
    @discardableResult
    public func onTapGesture(taps: Int = 1, touches: Int = 1, on state: UIGestureRecognizer.State = .ended, _ action: @escaping () -> Void) -> Self {
        onTapGesture(on: state) { v in
            action()
        }
    }
    
    @discardableResult
    public func onTapGesture(taps: Int = 1, touches: Int = 1, on state: UIGestureRecognizer.State = .ended, _ action: @escaping (Self) -> Void) -> Self {
        onTapGesture(taps: taps, touches: touches) { v, s, r in
            if s == state {
                action(v)
            }
        }
    }
    
    @discardableResult
    public func onTapGesture(taps: Int = 1, touches: Int = 1, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        onTapGesture(taps: taps, touches: touches) { v, s, r in
            action(v, s)
        }
    }
    
    @discardableResult
    public func onTapGesture(taps: Int = 1, touches: Int = 1, _ action: @escaping (Self, UIGestureRecognizer.State, TapGestureRecognizer) -> Void) -> Self {
        let recognizer = TapGestureRecognizer(taps: taps, touches: touches)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onTapGesture(taps: Int = 1, touches: Int = 1, _ state: UState<UIGestureRecognizer.State>) -> Self {
        onTapGesture(taps: taps, touches: touches) { v, s, r in
            state.wrappedValue = s
        }
    }

    @discardableResult
    public func onTapGesture<V>(taps: Int = 1, touches: Int = 1, _ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onTapGesture(taps: taps, touches: touches, expressable.unwrap())
    }
}

extension DeclarativeProtocol where V: UIControl {
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
    
    #if os(tvOS)
    @discardableResult
    public func onClickGesture(_ event: UIControl.Event = .primaryActionTriggered, _ action: @escaping () -> Void) -> Self {
        declarativeView.actionHandler(controlEvents: event, forAction: action)
        return self
    }
    
    @discardableResult
    public func onClickGesture(_ event: UIControl.Event = .primaryActionTriggered, _ action: @escaping (V) -> Void) -> Self {
        declarativeView.actionHandler(controlEvents: event) { [weak self] in
            guard let self = self as? V else { return }
            action(self)
        }
        return self
    }
    #endif
}
