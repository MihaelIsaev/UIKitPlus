#if os(macOS)
import AppKit

final public class PressGestureRecognizer: NSPressGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()

    public init(touches: Int = 1, minDuration: TimeInterval? = nil, allowableMovement: CGFloat? = nil, buttonMask: Int? = nil) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        numberOfTouchesRequired = touches
        if let minDuration = minDuration {
            minimumPressDuration = minDuration
        }
        if let allowableMovement = allowableMovement {
            self.allowableMovement = allowableMovement
        }
        if let buttonMask = buttonMask {
            self.buttonMask = buttonMask
        }
        delegate = _delegator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
//        debugPrint("PressGestureRecognizer deinit")
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
    
    @discardableResult
    public func buttonMask(_ v: Int) -> Self {
        buttonMask = v
        return self
    }
    
    @discardableResult
    public func buttonMask(_ state: UIKitPlus.State<Int>) -> Self {
        state.listen { self.buttonMask = $0 }
        return self
    }

    @discardableResult
    public func buttonMask<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        buttonMask(expressable.unwrap())
    }
    
    var _tag: Int = 0
    public override var tag: Int {
        get { _tag }
        set { _tag = newValue }
    }
}
#endif
