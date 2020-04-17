import UIKit

class _GestureDelegator: NSObject {
    weak var _outerDelegate: UIGestureRecognizerDelegate?
    
    var _shouldBegin: (() -> Bool)?
    var _shouldReceivePress: ((UIPress) -> Bool)?
    var _shouldReceiveTouch: ((UITouch) -> Bool)?
    var _shouldRequireFailureOfOtherGestureRecognizer: ((UIGestureRecognizer) -> Bool)?
    var _shouldBeRequiredToFailByOtherGestureRecognizer: ((UIGestureRecognizer) -> Bool)?
    var _shouldRecognizeSimultaneouslyWithOtherGestureRecognizer: ((UIGestureRecognizer) -> Bool)?
}

extension _GestureDelegator: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        _shouldBegin?() ?? _outerDelegate?.gestureRecognizerShouldBegin?(gestureRecognizer) ?? true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        _shouldReceivePress?(press)
            ?? _outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: press)
            ?? true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        _shouldReceiveTouch?(touch)
            ?? _outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch)
            ?? true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        _shouldRequireFailureOfOtherGestureRecognizer?(otherGestureRecognizer)
            ?? _outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer)
            ?? false
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        _shouldBeRequiredToFailByOtherGestureRecognizer?(otherGestureRecognizer)
            ?? _outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldBeRequiredToFailBy: otherGestureRecognizer)
            ?? false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        _shouldRecognizeSimultaneouslyWithOtherGestureRecognizer?(otherGestureRecognizer)
            ?? _outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer)
            ?? false
    }
}
