import UIKit

final public class PinchGestureRecognizer: UIPinchGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init(scale: CGFloat? = nil) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        if let scale = scale {
            self.scale = scale
        }
        delegate = _delegator
    }
    
    @discardableResult
    public func scale(_ v: CGFloat) -> Self {
        scale = v
        return self
    }
    
    @discardableResult
    public func scale(_ state: UIKitPlus.State<CGFloat>) -> Self {
        state.listen { self.scale = $0 }
        return self
    }

    @discardableResult
    public func scale<V>(_ expressable: ExpressableState<V, CGFloat>) -> Self {
        scale(expressable.unwrap())
    }
}
