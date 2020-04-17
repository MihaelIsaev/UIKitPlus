import UIKit

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
        shouldBegin(action)
    }
    
    @discardableResult
    public func shouldBegin(_ action: @escaping (Self) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldBegin = {
            action(self)
        }
        return self
    }
    
    // MARK: Should Receive Press
    
    @discardableResult
    public func shouldReceivePress(_ action: @escaping () -> Bool) -> Self {
        shouldReceivePress { _,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldReceivePress(_ action: @escaping (UIPress) -> Bool) -> Self {
        shouldReceivePress { _, p in
            action(p)
        }
    }
    
    @discardableResult
    public func shouldReceivePress(_ action: @escaping (Self, UIPress) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldReceivePress = { p in
            action(self, p)
        }
        return self
    }
    
    // MARK: Should Receive Touch
    
    @discardableResult
    public func shouldReceiveTouch(_ action: @escaping () -> Bool) -> Self {
        shouldReceiveTouch { _,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldReceiveTouch(_ action: @escaping (UITouch) -> Bool) -> Self {
        shouldReceiveTouch { _, t in
            action(t)
        }
    }
    
    @discardableResult
    public func shouldReceiveTouch(_ action: @escaping (Self, UITouch) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldReceiveTouch = { t in
            action(self, t)
        }
        return self
    }
    
    // MARK: Should Require Failure Of Other Gesture Recognizer
    
    @discardableResult
    public func shouldRequireFailureOfOtherGestureRecognizer(_ action: @escaping () -> Bool) -> Self {
        shouldRequireFailureOfOtherGestureRecognizer { _,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldRequireFailureOfOtherGestureRecognizer(_ action: @escaping (UIGestureRecognizer) -> Bool) -> Self {
        shouldRequireFailureOfOtherGestureRecognizer { _, o in
            action(o)
        }
    }
    
    @discardableResult
    public func shouldRequireFailureOfOtherGestureRecognizer(_ action: @escaping (Self, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldRequireFailureOfOtherGestureRecognizer = { o in
            action(self, o)
        }
        return self
    }
    
    // MARK: Should Be Required To Fail By Other Gesture Recognizer
    
    @discardableResult
    public func shouldBeRequiredToFailByOtherGestureRecognizer(_ action: @escaping () -> Bool) -> Self {
        shouldBeRequiredToFailByOtherGestureRecognizer { _,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldBeRequiredToFailByOtherGestureRecognizer(_ action: @escaping (UIGestureRecognizer) -> Bool) -> Self {
        shouldBeRequiredToFailByOtherGestureRecognizer { _, o in
            action(o)
        }
    }
    
    @discardableResult
    public func shouldBeRequiredToFailByOtherGestureRecognizer(_ action: @escaping (Self, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldBeRequiredToFailByOtherGestureRecognizer = { o in
            action(self, o)
        }
        return self
    }
    
    // MARK: Should Recognize Simultaneously With Other Gesture Recognizer
    
    @discardableResult
    public func shouldRecognizeSimultaneouslyWithOtherGestureRecognizer(_ action: @escaping () -> Bool) -> Self {
        shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { _,_ in
            action()
        }
    }
    
    @discardableResult
    public func shouldRecognizeSimultaneouslyWithOtherGestureRecognizer(_ action: @escaping (UIGestureRecognizer) -> Bool) -> Self {
        shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { _, o in
            action(o)
        }
    }
    
    @discardableResult
    public func shouldRecognizeSimultaneouslyWithOtherGestureRecognizer(_ action: @escaping (Self, UIGestureRecognizer) -> Bool) -> Self {
        guard let s = self as? _GestureDelegatorable else { return self }
        s._delegator._shouldRecognizeSimultaneouslyWithOtherGestureRecognizer = { o in
            action(self, o)
        }
        return self
    }
}
