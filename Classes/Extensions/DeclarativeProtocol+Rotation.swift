import UIKit

#if !os(tvOS)
extension DeclarativeProtocol {
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, on state: UIGestureRecognizer.State, _ action: @escaping () -> Void) -> Self {
        onRotationGesture(rotation: rotation, on: state) { v, r in
            action()
        }
    }
    
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, on state: UIGestureRecognizer.State, _ action: @escaping (Self) -> Void) -> Self {
        onRotationGesture(rotation: rotation, on: state) { v, r in
            action(self)
        }
    }
    
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, on state: UIGestureRecognizer.State, _ action: @escaping (Self, RotationGestureRecognizer) -> Void) -> Self {
        onRotationGesture(rotation: rotation) { v, s, r in
            if s == state {
                action(v, r)
            }
        }
    }
    
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, _ action: @escaping (Self) -> Void) -> Self {
        onRotationGesture(rotation: rotation) { v, s, r in
            action(v)
        }
    }
    
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        onRotationGesture(rotation: rotation) { v, s, r in
            action(v, s)
        }
    }
    
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, _ action: @escaping (Self, UIGestureRecognizer.State, RotationGestureRecognizer) -> Void) -> Self {
        let recognizer = RotationGestureRecognizer(rotation: rotation)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onRotationGesture(rotation: CGFloat? = nil, _ state: UState<UIGestureRecognizer.State>) -> Self {
        onRotationGesture(rotation: rotation) { v, s, r in
            state.wrappedValue = s
        }
    }

    @discardableResult
    public func onRotationGesture<V>(rotation: CGFloat? = nil, _ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onRotationGesture(rotation: rotation, expressable.unwrap())
    }
}
#endif
