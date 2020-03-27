import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, _ action: @escaping (ScreenEdgePanGestureRecognizer) -> Void) -> Self {
        let recognizer = ScreenEdgePanGestureRecognizer(edges: edges)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, _ action: @escaping (Self, ScreenEdgePanGestureRecognizer) -> Void) -> Self {
        let recognizer = ScreenEdgePanGestureRecognizer(edges: edges)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(self, recognizer)
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
