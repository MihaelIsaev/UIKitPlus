import UIKit

class _GestureDelegator: NSObject, UIGestureRecognizerDelegate, _GestureRecognizerDelegatable {
    weak var _outerDelegate: UIGestureRecognizerDelegate?
    
    var _shouldBegin: ((UIGestureRecognizer) -> Bool)?
    var _shouldReceivePress: ((UIGestureRecognizer, UIPress) -> Bool)?
    var _shouldReceiveTouch: ((UIGestureRecognizer, UITouch) -> Bool)?
    var _shouldRequireFailureOfOtherGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _shouldBeRequiredToFailByOtherGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
    var _shouldRecognizeSimultaneouslyWithOtherGestureRecognizer: ((UIGestureRecognizer, UIGestureRecognizer) -> Bool)?
}

public protocol GestureDelegatorable {}

protocol _GestureDelegatorable: GestureDelegatorable {
    var _delegator: _GestureDelegator { get set }
}

extension GestureDelegatorable {
    @discardableResult
    public func delegate(_ object: UIGestureRecognizerDelegate) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._outerDelegate = object
        return self
    }
    
    // MARK: Should Begin
    
    @discardableResult
    public func shouldBegin(_ action: @escaping () -> Bool) -> Self {
        shouldBegin { _,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldBegin(_ action: @escaping (UIGestureRecognizer) -> Bool) -> Self {
        shouldBegin { _, r in
            action(r)
        }
    }
    
    @discardableResult
    public func shouldBegin(_ action: @escaping (Self, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldBegin = {
            action(self, $0)
        }
        return self
    }
    
    // MARK: Should Receive Press
    
    @discardableResult
    public func shouldReceivePress(_ action: @escaping () -> Bool) -> Self {
        shouldReceivePress { _,_,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldReceivePress(_ action: @escaping (UIGestureRecognizer, UIPress) -> Bool) -> Self {
        shouldReceivePress { _, r, p in
            action(r, p)
        }
    }
    
    @discardableResult
    public func shouldReceivePress(_ action: @escaping (Self, UIGestureRecognizer, UIPress) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldReceivePress = { r, p in
            action(self, r, p)
        }
        return self
    }
    
    // MARK: Should Receive Touch
    
    @discardableResult
    public func shouldReceiveTouch(_ action: @escaping () -> Bool) -> Self {
        shouldReceiveTouch { _,_,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldReceiveTouch(_ action: @escaping (UIGestureRecognizer, UITouch) -> Bool) -> Self {
        shouldReceiveTouch { _, r, t in
            action(r, t)
        }
    }
    
    @discardableResult
    public func shouldReceiveTouch(_ action: @escaping (Self, UIGestureRecognizer, UITouch) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldReceiveTouch = { r, t in
            action(self, r, t)
        }
        return self
    }
    
    // MARK: Should Require Failure Of Other Gesture Recognizer
    
    @discardableResult
    public func shouldRequireFailureOfOtherGestureRecognizer(_ action: @escaping () -> Bool) -> Self {
        shouldRequireFailureOfOtherGestureRecognizer { _,_,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldRequireFailureOfOtherGestureRecognizer(_ action: @escaping (UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        shouldRequireFailureOfOtherGestureRecognizer { _, r, o in
            action(r, o)
        }
    }
    
    @discardableResult
    public func shouldRequireFailureOfOtherGestureRecognizer(_ action: @escaping (Self, UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldRequireFailureOfOtherGestureRecognizer = { r, o in
            action(self, r, o)
        }
        return self
    }
    
    // MARK: Should Be Required To Fail By Other Gesture Recognizer
    
    @discardableResult
    public func shouldBeRequiredToFailByOtherGestureRecognizer(_ action: @escaping () -> Bool) -> Self {
        shouldBeRequiredToFailByOtherGestureRecognizer { _,_,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldBeRequiredToFailByOtherGestureRecognizer(_ action: @escaping (UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        shouldBeRequiredToFailByOtherGestureRecognizer { _, r, o in
            action(r, o)
        }
    }
    
    @discardableResult
    public func shouldBeRequiredToFailByOtherGestureRecognizer(_ action: @escaping (Self, UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldBeRequiredToFailByOtherGestureRecognizer = { r, o in
            action(self, r, o)
        }
        return self
    }
    
    // MARK: Should Recognize Simultaneously With Other Gesture Recognizer
    
    @discardableResult
    public func shouldRecognizeSimultaneouslyWithOtherGestureRecognizer(_ action: @escaping () -> Bool) -> Self {
        shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { _,_,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldRecognizeSimultaneouslyWithOtherGestureRecognizer(_ action: @escaping (UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { _, r, o in
            action(r, o)
        }
    }
    
    @discardableResult
    public func shouldRecognizeSimultaneouslyWithOtherGestureRecognizer(_ action: @escaping (Self, UIGestureRecognizer, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldRecognizeSimultaneouslyWithOtherGestureRecognizer = { r, o in
            action(self, r, o)
        }
        return self
    }
}
