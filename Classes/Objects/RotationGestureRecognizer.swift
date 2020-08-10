#if !os(macOS)
import UIKit

#if !os(tvOS)
final public class RotationGestureRecognizer: UIRotationGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init(rotation: CGFloat? = nil) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        if let rotation = rotation {
            self.rotation = rotation
        }
        delegate = _delegator
    }
    
    @discardableResult
    public func rotation(_ v: CGFloat) -> Self {
        rotation = v
        return self
    }
    
    @discardableResult
    public func rotation(_ state: UIKitPlus.State<CGFloat>) -> Self {
        state.listen { self.rotation = $0 }
        return self
    }

    @discardableResult
    public func rotation<V>(_ expressable: ExpressableState<V, CGFloat>) -> Self {
        rotation(expressable.unwrap())
    }
    
    var _tag: Int = 0
    public override var tag: Int {
        get { _tag }
        set { _tag = newValue }
    }
}
#endif
#endif
