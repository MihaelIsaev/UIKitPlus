#if !os(macOS)
import UIKit

#if !os(tvOS)
extension DeclarativeProtocol {
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, on state: UIGestureRecognizer.State, _ action: @escaping () -> Void) -> Self {
        onScreenEdgePanGesture(edges: edges, on: state) { v, r in
            action()
        }
    }
    
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, on state: UIGestureRecognizer.State, _ action: @escaping (Self) -> Void) -> Self {
        onScreenEdgePanGesture(edges: edges, on: state) { v, r in
            action(self)
        }
    }
    
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, on state: UIGestureRecognizer.State, _ action: @escaping (Self, ScreenEdgePanGestureRecognizer) -> Void) -> Self {
        onScreenEdgePanGesture(edges: edges) { v, s, r in
            if s == state {
                action(v, r)
            }
        }
    }
    
    @discardableResult
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        onScreenEdgePanGesture(edges: edges) { v, s, r in
            action(v, s)
        }
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
    public func onScreenEdgePanGesture(edges: UIRectEdge = .all, _ state: State<UIGestureRecognizer.State>) -> Self {
        onScreenEdgePanGesture(edges: edges) { v, s, r in
            state.wrappedValue = s
        }
    }
}
#endif
#endif
