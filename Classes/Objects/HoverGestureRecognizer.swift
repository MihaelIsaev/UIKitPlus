import UIKit

@available(iOS 13.0, *)
final public class HoverGestureRecognizer: UIHoverGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init() {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        delegate = _delegator
    }
}
