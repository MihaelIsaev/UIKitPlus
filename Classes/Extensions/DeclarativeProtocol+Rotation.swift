import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onRotaionGesture(rotation: CGFloat? = nil, _ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(RotationGestureRecognizer(rotation: rotation).trackState(action))
        return self
    }
    
    @discardableResult
    public func onRotaionGesture(rotation: CGFloat? = nil, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(RotationGestureRecognizer(rotation: rotation).trackState {
            action(self, $0)
        })
        return self
    }
    
    @discardableResult
    public func onRotaionGesture(rotation: CGFloat? = nil, _ action: @escaping (Self, UIGestureRecognizer.State, RotationGestureRecognizer) -> Void) -> Self {
        let recognizer = RotationGestureRecognizer(rotation: rotation)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onRotaionGesture(_ state: State<UIGestureRecognizer.State>, rotation: CGFloat? = nil) -> Self {
        declarativeView.addGestureRecognizer(RotationGestureRecognizer(rotation: rotation).trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onRotaionGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>, rotation: CGFloat? = nil) -> Self {
        onRotaionGesture(expressable.unwrap(), rotation: rotation)
    }
}
