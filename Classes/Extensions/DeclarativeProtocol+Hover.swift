import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onHoverGesture(_ action: @escaping (Self) -> Void) -> Self {
        onHoverGesture { v, s, r in
            action(v)
        }
    }
    
    @discardableResult
    public func onHoverGesture(_ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        onHoverGesture { v, s, r in
            action(v, s)
        }
    }
    
    @discardableResult
    public func onHoverGesture(_ action: @escaping (Self, UIGestureRecognizer.State, UIGestureRecognizer) -> Void) -> Self {
        if #available(iOS 13.0, *) {
            let recognizer = HoverGestureRecognizer()
            declarativeView.addGestureRecognizer(recognizer.trackState {
                action(self, $0, recognizer)
            })
        }
        return self
    }
    
    @discardableResult
    public func onHoverGesture(_ state: State<UIGestureRecognizer.State>) -> Self {
        onHoverGesture { v, s, r in
            state.wrappedValue = s
        }
    }

    @discardableResult
    public func onHoverGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onHoverGesture(expressable.unwrap())
    }
    
    @discardableResult
    public func hovered(_ action: @escaping (Bool) -> Void) -> Self {
        onHoverGesture { v, s, r in
            let hovered = [.began, .changed].contains(s)
            guard hovered != self.properties.hovered else { return }
            self.properties.hovered = hovered
            action(hovered)
        }
    }
    
    @discardableResult
    public func hovered(_ state: State<Bool>) -> Self {
        hovered {
            state.wrappedValue = $0
        }
    }

    @discardableResult
    public func hovered<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        hovered(expressable.unwrap())
    }
}
