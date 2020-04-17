import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, on state: UIGestureRecognizer.State, _ action: @escaping () -> Void) -> Self {
        onSwipeGesture(direction: direction, touches: touches, on: state) { action() }
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, on state: UIGestureRecognizer.State, _ action: @escaping (Self) -> Void) -> Self {
        onSwipeGesture(direction: direction, touches: touches) { v, s, r in
            if s == state {
                action(v)
            }
        }
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, _ action: @escaping () -> Void) -> Self {
        onSwipeGesture(direction: direction, touches: touches) { v, s, r in
            action()
        }
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, _ action: @escaping (Self) -> Void) -> Self {
        onSwipeGesture(direction: direction, touches: touches) { v, s, r in
            action(v)
        }
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        onSwipeGesture(direction: direction, touches: touches) { v, s, r in
            action(v, s)
        }
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil, _ action: @escaping (Self, UIGestureRecognizer.State, SwipeGestureRecognizer) -> Void) -> Self {
        let recognizer = SwipeGestureRecognizer(direction: direction, touches: touches)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil, _ state: State<UIGestureRecognizer.State>) -> Self {
        onSwipeGesture(direction: direction, touches: touches) { v, s, r in
            state.wrappedValue = s
        }
        return self
    }

    @discardableResult
    public func onSwipeGesture<V>(direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil, _ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onSwipeGesture(direction: direction, touches: touches, expressable.unwrap())
    }
}
