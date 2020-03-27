import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil, _ action: @escaping (SwipeGestureRecognizer) -> Void) -> Self {
        let recognizer = SwipeGestureRecognizer(direction: direction, touches: touches)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onSwipeGesture(direction: UISwipeGestureRecognizer.Direction, touches: Int? = nil, _ action: @escaping (Self, SwipeGestureRecognizer) -> Void) -> Self {
        let recognizer = SwipeGestureRecognizer(direction: direction, touches: touches)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(self, recognizer)
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
