import UIKit

final public class TapGestureRecognizer: UITapGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init(taps: Int = 1, touches: Int = 1) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        numberOfTapsRequired = taps
        numberOfTouchesRequired = touches
        delegate = _delegator
    }
    
    @discardableResult
    public func numberOfTapsRequired(_ v: Int) -> Self {
        numberOfTapsRequired = v
        return self
    }
    
    @discardableResult
    public func numberOfTapsRequired(_ state: UIKitPlus.State<Int>) -> Self {
        state.listen { self.numberOfTapsRequired = $0 }
        return self
    }

    @discardableResult
    public func numberOfTapsRequired<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        numberOfTapsRequired(expressable.unwrap())
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
    
    var _tag: Int = 0
    public override var tag: Int {
        get { _tag }
        set { _tag = newValue }
    }
}
