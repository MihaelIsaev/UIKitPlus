import UIKit

final public class LongPressGestureRecognizer: UILongPressGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()

    public init(taps: Int = 0, touches: Int = 1, minDuration: TimeInterval? = nil, allowableMovement: CGFloat? = nil) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        numberOfTapsRequired = taps
        #if os(iOS)
        numberOfTouchesRequired = touches
        #endif
        if let minDuration = minDuration {
            minimumPressDuration = minDuration
        }
        if let allowableMovement = allowableMovement {
            self.allowableMovement = allowableMovement
        }
        delegate = _delegator
    }
    
    deinit {
//        debugPrint("LongPressGestureRecognizer deinit")
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
    
    #if os(iOS)
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
    #endif
    
    @discardableResult
    public func minimumPressDuration(_ v: TimeInterval) -> Self {
        minimumPressDuration = v
        return self
    }
    
    @discardableResult
    public func minimumPressDuration(_ state: UIKitPlus.State<TimeInterval>) -> Self {
        state.listen { self.minimumPressDuration = $0 }
        return self
    }

    @discardableResult
    public func minimumPressDuration<V>(_ expressable: ExpressableState<V, TimeInterval>) -> Self {
        minimumPressDuration(expressable.unwrap())
    }
    
    @discardableResult
    public func allowableMovement(_ v: CGFloat) -> Self {
        allowableMovement = v
        return self
    }
    
    @discardableResult
    public func allowableMovement(_ state: UIKitPlus.State<CGFloat>) -> Self {
        state.listen { self.allowableMovement = $0 }
        return self
    }

    @discardableResult
    public func allowableMovement<V>(_ expressable: ExpressableState<V, CGFloat>) -> Self {
        allowableMovement(expressable.unwrap())
    }
    
    var _tag: Int = 0
    public override var tag: Int {
        get { _tag }
        set { _tag = newValue }
    }
}
