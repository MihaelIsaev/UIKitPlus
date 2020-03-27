import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onRotaionGesture(rotation: CGFloat? = nil, _ action: @escaping (RotationGestureRecognizer) -> Void) -> Self {
        let recognizer = RotationGestureRecognizer(rotation: rotation)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onRotaionGesture(rotation: CGFloat? = nil, _ action: @escaping (Self, RotationGestureRecognizer) -> Void) -> Self {
        let recognizer = RotationGestureRecognizer(rotation: rotation)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(self, recognizer)
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
