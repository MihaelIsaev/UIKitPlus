import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, on state: UIGestureRecognizer.State, _ action: @escaping () -> Void) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches, on: state) { v, r in
            action()
        }
    }
    
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, on state: UIGestureRecognizer.State, _ action: @escaping (Self) -> Void) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches, on: state) { v, r in
            action(self)
        }
    }
    
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, on state: UIGestureRecognizer.State, _ action: @escaping (Self, PanGestureRecognizer) -> Void) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches) { v, s, r in
            if s == state {
                action(v, r)
            }
        }
    }
    
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, _ action: @escaping (Self) -> Void) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches) { v, s, r in
            action(v)
        }
    }
    
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, _ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches) { v, s, r in
            action(v, s)
        }
    }
    
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, _ action: @escaping (Self, UIGestureRecognizer.State, PanGestureRecognizer) -> Void) -> Self {
        let recognizer = PanGestureRecognizer(minTouches: minTouches, maxTouches: maxTouches)
        declarativeView.addGestureRecognizer(recognizer.trackState {
            action(self, $0, recognizer)
        })
        return self
    }
    
    @discardableResult
    public func onPanGesture(minTouches: Int? = nil, maxTouches: Int? = nil, _ state: UState<UIGestureRecognizer.State>) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches) { v, s, r in
            state.wrappedValue = s
        }
    }

    @discardableResult
    public func onPanGesture<V>(minTouches: Int? = nil, maxTouches: Int? = nil, _ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        onPanGesture(minTouches: minTouches, maxTouches: maxTouches, expressable.unwrap())
    }
}
