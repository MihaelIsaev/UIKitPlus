import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onHoverGesture(_ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        if #available(iOSApplicationExtension 13.0, *) {
            declarativeView.addGestureRecognizer(HoverGestureRecognizer().trackState(action))
        }
        return self
    }
    
    @discardableResult
    public func onHoverGesture(_ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        if #available(iOSApplicationExtension 13.0, *) {
            declarativeView.addGestureRecognizer(HoverGestureRecognizer().trackState {
                action(self, $0)
            })
        }
        return self
    }
    
    @discardableResult
    public func onHoverGesture(_ action: @escaping (Self, UIGestureRecognizer.State, UIGestureRecognizer) -> Void) -> Self {
        if #available(iOSApplicationExtension 13.0, *) {
            let recognizer = HoverGestureRecognizer()
            declarativeView.addGestureRecognizer(recognizer.trackState {
                action(self, $0, recognizer)
            })
        }
        return self
    }
    
    @discardableResult
    public func onHoverGesture(_ state: State<UIGestureRecognizer.State>) -> Self {
        if #available(iOSApplicationExtension 13.0, *) {
            declarativeView.addGestureRecognizer(HoverGestureRecognizer().trackState {
                state.wrappedValue = $0
            })
        }
        return self
    }

    @discardableResult
    public func onHoverGesture<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onHoverGesture(expressable.unwrap())
    }
    
    @discardableResult
    public func hovered(_ action: @escaping (Bool) -> Void) -> Self {
        if #available(iOSApplicationExtension 13.0, *) {
            declarativeView.addGestureRecognizer(HoverGestureRecognizer().trackState {
                let hovered = [.began, .changed].contains($0)
                guard hovered != self.properties.hovered else { return }
                self.properties.hovered = hovered
                action(hovered)
            })
        }
        return self
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
