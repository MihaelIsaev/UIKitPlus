import UIKit

final public class PanGestureRecognizer: UIPanGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init(minTouches: Int? = nil, maxTouches: Int? = nil) {
        super.init(target: nil, action: nil)
        if let minTouches = minTouches {
            minimumNumberOfTouches = minTouches
        }
        if let maxTouches = maxTouches {
            maximumNumberOfTouches = maxTouches
        }
        addTarget(_tracker, action: #selector(_tracker.handle))
        delegate = _delegator
    }
    
    @discardableResult
    public func minimumNumberOfTouches(_ v: Int) -> Self {
        minimumNumberOfTouches = v
        return self
    }
    
    @discardableResult
    public func minimumNumberOfTouches(_ state: UIKitPlus.State<Int>) -> Self {
        state.listen { self.minimumNumberOfTouches = $0 }
        return self
    }

    @discardableResult
    public func minimumNumberOfTouches<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        minimumNumberOfTouches(expressable.unwrap())
    }
    
    @discardableResult
    public func maximumNumberOfTouches(_ v: Int) -> Self {
        maximumNumberOfTouches = v
        return self
    }
    
    @discardableResult
    public func maximumNumberOfTouches(_ state: UIKitPlus.State<Int>) -> Self {
        state.listen { self.maximumNumberOfTouches = $0 }
        return self
    }

    @discardableResult
    public func maximumNumberOfTouches<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        maximumNumberOfTouches(expressable.unwrap())
    }
    
    var _tag: Int = 0
    public override var tag: Int {
        get { _tag }
        set { _tag = newValue }
    }
}
