import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onSwipeGesture(edges: UIRectEdge = .all, _ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(ScreenEdgePanGestureRecognizer(edges: edges).trackState(action))
        return self
    }
    
    @discardableResult
    public func onSwipeGesture(edges: UIRectEdge = .all, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(ScreenEdgePanGestureRecognizer(edges: edges).trackState {
            action(self, $0)
        })
        return self
    }
    
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, _ action: @escaping (Self, UIGestureRecognizer.State, ScreenEdgePanGestureRecognizer) -> Void) -> Self {
        let recognizer = ScreenEdgePanGestureRecognizer(edges: edges)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onScreenEdgePanGesture(_ state: State<UIGestureRecognizer.State>, edges: UIRectEdge = .all) -> Self {
        declarativeView.addGestureRecognizer(ScreenEdgePanGestureRecognizer(edges: edges).trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onScreenEdgePanGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onPanGesture(expressable.unwrap())
    }
}
