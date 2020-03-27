import UIKit

final public class SwipeGestureRecognizer: UISwipeGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init(direction d: UISwipeGestureRecognizer.Direction, touches: Int? = nil) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        if let touches = touches {
            numberOfTouchesRequired = touches
        }
        direction = d
        delegate = _delegator
    }
    
    @discardableResult
    public func numberOfTouchesRequired(_ v: Int) -> Self {
        numberOfTouchesRequired = v
        return self
    }
    
    @discardableResult
    public func numberOfTouchesRequired(_ state: UIKitPlus.State<Int>) -> Self {
        state.listen { self.numberOfTouchesRequired = $0 }
        return self
    }

    @discardableResult
    public func numberOfTouchesRequired<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        numberOfTouchesRequired(expressable.unwrap())
    }
    
    @discardableResult
    public func direction(_ v: UISwipeGestureRecognizer.Direction) -> Self {
        direction = v
        return self
    }
    
    @discardableResult
    public func direction(_ state: UIKitPlus.State<UISwipeGestureRecognizer.Direction>) -> Self {
        state.listen { self.direction = $0 }
        return self
    }

    @discardableResult
    public func direction<V>(_ expressable: ExpressableState<V, UISwipeGestureRecognizer.Direction>) -> Self {
        direction(expressable.unwrap())
    }
}
