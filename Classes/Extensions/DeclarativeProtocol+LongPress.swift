import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onLongPressGesture(taps: Int = 0, touches: Int = 1, _ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(LongPressGestureRecognizer(taps: taps, touches: touches).trackState(action))
        return self
    }
    
    @discardableResult
    public func onLongPressGesture(taps: Int = 0, touches: Int = 1, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(LongPressGestureRecognizer(taps: taps, touches: touches).trackState {
            action(self, $0)
        })
        return self
    }
    
    @discardableResult
    public func onLongPressGesture(taps: Int = 0, touches: Int = 1, _ action: @escaping (Self, UIGestureRecognizer.State, LongPressGestureRecognizer) -> Void) -> Self {
        let recognizer = LongPressGestureRecognizer(taps: taps, touches: touches)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onLongPressGesture(on state: UIGestureRecognizer.State = .began, taps: Int = 0, touches: Int = 1, _ action: @escaping () -> Void) -> Self {
        declarativeView.addGestureRecognizer(LongPressGestureRecognizer(taps: taps, touches: touches).trackState {
            switch $0 {
            case state: action()
            default: break
            }
        })
        return self
    }
    
    @discardableResult
    public func onLongPressGesture(on state: UIGestureRecognizer.State = .began, taps: Int = 0, touches: Int = 1, _ action: @escaping (Self) -> Void) -> Self {
        declarativeView.addGestureRecognizer(LongPressGestureRecognizer(taps: taps, touches: touches).trackState {
            switch $0 {
            case state: action(self)
            default: break
            }
        })
        return self
    }
    
    @discardableResult
    public func onLongPressGesture(_ state: State<UIGestureRecognizer.State>, taps: Int = 0, touches: Int = 1) -> Self {
        declarativeView.addGestureRecognizer(LongPressGestureRecognizer(taps: taps, touches: touches).trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onLongPressGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>, taps: Int = 0, touches: Int = 1) -> Self {
        onLongPressGesture(expressable.unwrap(), taps: taps, touches: touches)
    }
}
