import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onPinchGesture(scale: CGFloat? = nil, _ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(PinchGestureRecognizer(scale: scale).trackState(action))
        return self
    }
    
    @discardableResult
    public func onPinchGesture(scale: CGFloat? = nil, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        declarativeView.addGestureRecognizer(PinchGestureRecognizer(scale: scale).trackState {
            action(self, $0)
        })
        return self
    }
    
    @discardableResult
    public func onPinchGesture(scale: CGFloat? = nil, _ action: @escaping (Self, UIGestureRecognizer.State, PinchGestureRecognizer) -> Void) -> Self {
        let recognizer = PinchGestureRecognizer(scale: scale)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
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
