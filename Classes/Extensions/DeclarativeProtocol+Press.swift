#if os(macOS)
import AppKit

extension DeclarativeProtocol {
    @discardableResult
    public func onPressGesture(touches: Int = 1, on state: NSGestureRecognizer.State = .began, _ action: @escaping () -> Void) -> Self {
        onPressGesture(touches: touches, on: state) { v, r in
            action()
        }
    }
    
    @discardableResult
    public func onPressGesture(touches: Int = 1, on state: NSGestureRecognizer.State, _ action: @escaping (Self) -> Void) -> Self {
        onPressGesture(touches: touches, on: state) { v, r in
            action(self)
        }
    }
    
    @discardableResult
    public func onPressGesture(touches: Int = 1, on state: NSGestureRecognizer.State, _ action: @escaping (Self, PressGestureRecognizer) -> Void) -> Self {
        onPressGesture(touches: touches) { v, s, r in
            if s == state {
                action(v, r)
            }
        }
    }
    
    @discardableResult
    public func onPressGesture(touches: Int = 1, _ action: @escaping (Self) -> Void) -> Self {
        onPressGesture(touches: touches) { v, s, r in
            action(v)
        }
    }
    
    @discardableResult
    public func onPressGesture(touches: Int = 1, _ action: @escaping (Self, NSGestureRecognizer.State) -> Void) -> Self {
        onPressGesture(touches: touches) { v, s, r in
            action(v, s)
        }
    }
    
    @discardableResult
    public func onPressGesture(touches: Int = 1, _ action: @escaping (Self, NSGestureRecognizer.State, PressGestureRecognizer) -> Void) -> Self {
        let recognizer = PressGestureRecognizer(touches: touches)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onPressGesture(touches: Int = 1, _ state: State<NSGestureRecognizer.State>) -> Self {
        onPressGesture(touches: touches) { v, s, r in
            state.wrappedValue = s
        }
    }
}
#endif
