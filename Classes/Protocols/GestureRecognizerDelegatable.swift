import UIKit

public protocol GestureRecognizerDelegatable {}

protocol _GestureRecognizerDelegatable: GestureRecognizerDelegatable {
    var _outerDelegate: UIGestureRecognizerDelegate? { get set }
    
    var _shouldBegin: ((UIGestureRecognizer) -> Bool)? { get set }
    var _shouldReceivePress: ((UIGestureRecognizer, UIPress) -> Bool)? { get set }
    var _shouldReceiveTouch: ((UIGestureRecognizer, UITouch) -> Bool)? { get set }
    var _shouldRequireFailureOfOtherGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)? { get set }
    var _shouldBeRequiredToFailByOtherGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)? { get set }
    var _shouldRecognizeSimultaneouslyWithOtherGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)? { get set }
}

extension GestureRecognizerDelegatable {
    @discardableResult
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let s = self as? _GestureRecognizerDelegatable else { return true }
        return s._shouldBegin?(gestureRecognizer) ?? s._outerDelegate?.gestureRecognizerShouldBegin?(gestureRecognizer) ?? true
    }
    
    @discardableResult
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        guard let s = self as? _GestureRecognizerDelegatable else { return true }
        return s._shouldReceivePress?(gestureRecognizer, press)
            ?? s._outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: press) ?? true
            ?? true
    }
    
    @discardableResult
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let s = self as? _GestureRecognizerDelegatable else { return true }
        return s._shouldReceiveTouch?(gestureRecognizer, touch)
            ?? s._outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) ?? true
            ?? true
    }
    
    @discardableResult
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let s = self as? _GestureRecognizerDelegatable else { return true }
        return s._shouldRequireFailureOfOtherGestureRecognizer?(gestureRecognizer, otherGestureRecognizer)
            ?? s._outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer) ?? true
            ?? true
    }
    
    @discardableResult
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let s = self as? _GestureRecognizerDelegatable else { return true }
        return s._shouldBeRequiredToFailByOtherGestureRecognizer?(gestureRecognizer, otherGestureRecognizer)
            ?? s._outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldBeRequiredToFailBy: otherGestureRecognizer) ?? true
            ?? true
    }
    
    @discardableResult
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let s = self as? _GestureRecognizerDelegatable else { return true }
        return s._shouldRecognizeSimultaneouslyWithOtherGestureRecognizer?(gestureRecognizer, otherGestureRecognizer)
            ?? s._outerDelegate?.gestureRecognizer?(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer) ?? true
            ?? true
    }
}
