import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onPinchGesture(scale: CGFloat? = nil, _ action: @escaping (PinchGestureRecognizer) -> Void) -> Self {
        let recognizer = PinchGestureRecognizer(scale: scale)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onPinchGesture(scale: CGFloat? = nil, _ action: @escaping (Self, PinchGestureRecognizer) -> Void) -> Self {
        let recognizer = PinchGestureRecognizer(scale: scale)
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(self, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onPinchGesture(_ state: State<UIGestureRecognizer.State>, scale: CGFloat? = nil) -> Self {
        declarativeView.addGestureRecognizer(PinchGestureRecognizer(scale: scale).trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onPinchGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>, scale: CGFloat? = nil) -> Self {
        onPinchGesture(expressable.unwrap(), scale: scale)
    }
}
