import UIKit

extension DeclarativeProtocol where V: UIView {
    @discardableResult
    public func onTapGesture(on state: UIGestureRecognizer.State = .ended, taps: Int = 1, touches: Int = 1, _ action: @escaping () -> Void) -> Self {
        declarativeView.addGestureRecognizer(TapGestureRecognizer(taps: taps, touches: touches).trackState {
            switch $0 {
            case state: action()
            default: break
            }
        })
        return self
    }
    
    @discardableResult
    public func onTapGesture(on state: UIGestureRecognizer.State = .ended, taps: Int = 1, touches: Int = 1, _ action: @escaping (Self) -> Void) -> Self {
        declarativeView.addGestureRecognizer(TapGestureRecognizer(taps: taps, touches: touches).trackState {
            switch $0 {
            case state: action(self)
            default: break
            }
        })
        return self
    }
    
    @discardableResult
    public func onTapGesture(_ state: State<UIGestureRecognizer.State>, taps: Int = 1, touches: Int = 1) -> Self {
        declarativeView.addGestureRecognizer(TapGestureRecognizer(taps: taps, touches: touches).trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onTapGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>, taps: Int = 1, touches: Int = 1) -> Self {
        onTapGesture(expressable.unwrap(), taps: taps, touches: touches)
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
}
