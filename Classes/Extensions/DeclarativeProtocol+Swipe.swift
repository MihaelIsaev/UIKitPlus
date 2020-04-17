import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, _ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(SwipeGestureRecognizer(direction: direction, touches: touches).trackState(action))
        return self
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int = 1, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(SwipeGestureRecognizer(direction: direction, touches: touches).trackState {
            action(self, $0)
        })
        return self
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
    public func onSwipeGesture(_ state: State<UIGestureRecognizer.State>, direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil) -> Self {
        declarativeView.addGestureRecognizer(SwipeGestureRecognizer(direction: direction, touches: touches).trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onSwipeGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>, direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil) -> Self {
        onSwipeGesture(expressable.unwrap(), direction: direction, touches: touches)
    }
}
