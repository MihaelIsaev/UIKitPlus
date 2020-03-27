import UIKit

@available(iOS 13.0, *)
extension DeclarativeProtocol {
    @discardableResult
    public func onHoverGesture(_ action: @escaping (HoverGestureRecognizer) -> Void) -> Self {
        let recognizer = HoverGestureRecognizer()
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onHoverGesture(_ action: @escaping (Self, HoverGestureRecognizer) -> Void) -> Self {
        let recognizer = HoverGestureRecognizer()
        declarativeView.addGestureRecognizer(recognizer.trackState { _ in
            action(self, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onHoverGesture(_ state: State<UIGestureRecognizer.State>) -> Self {
        declarativeView.addGestureRecognizer(HoverGestureRecognizer().trackState {
            state.wrappedValue = $0
        })
        return self
    }

    @discardableResult
    public func onHoverGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onHoverGesture(expressable.unwrap())
    }
}
