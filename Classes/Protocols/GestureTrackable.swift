import UIKit

public protocol GestureTrackable {
    @discardableResult
    func trackState(_ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self
    
    @discardableResult
    func trackState(_ action: @escaping (UIGestureRecognizer.State, Self) -> Void) -> Self
    
    @discardableResult
    func trackState(_ state: State<UIGestureRecognizer.State>) -> Self
    
    @discardableResult
    func trackState<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self
    
    @discardableResult
    func onPossible(_ action: @escaping () -> Void) -> Self
    @discardableResult
    func onPossible(_ action: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onBegan(_ action: @escaping () -> Void) -> Self
    @discardableResult
    func onBegan(_ action: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onChanged(_ action: @escaping () -> Void) -> Self
    @discardableResult
    func onChanged(_ action: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onEnded(_ action: @escaping () -> Void) -> Self
    @discardableResult
    func onEnded(_ action: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onCancelled(_ action: @escaping () -> Void) -> Self
    @discardableResult
    func onCancelled(_ action: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onFailed(_ action: @escaping () -> Void) -> Self
    @discardableResult
    func onFailed(_ action: @escaping (Self) -> Void) -> Self
}

protocol _GestureTrackable: GestureTrackable {
    var _tracker: _GestureTracker { get set }
}

extension GestureTrackable {
    @discardableResult
    public func trackState<V>(_ expressable: ExpressableState<V, UIGestureRecognizer.State>) -> Self {
        trackState(expressable.unwrap())
    }
    
    @discardableResult
    public func onPossible(_ action: @escaping () -> Void) -> Self {
        onPossible { _ in action() }
    }
    
    @discardableResult
    public func onBegan(_ action: @escaping () -> Void) -> Self {
        onBegan { _ in action() }
    }
    
    @discardableResult
    public func onChanged(_ action: @escaping () -> Void) -> Self {
        onChanged { _ in action() }
    }
    
    @discardableResult
    public func onEnded(_ action: @escaping () -> Void) -> Self {
        onEnded { _ in action() }
    }
    
    @discardableResult
    public func onCancelled(_ action: @escaping () -> Void) -> Self {
        onCancelled { _ in action() }
    }
    
    @discardableResult
    public func onFailed(_ action: @escaping () -> Void) -> Self {
        onFailed { _ in action() }
    }
}

@available(iOS 13.0, *)
extension GestureTrackable {
    @discardableResult
    public func trackState(_ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.change = action
        return self
    }
    
    @discardableResult
    public func trackState(_ action: @escaping (UIGestureRecognizer.State, Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.change = {
            action($0, self)
        }
        return self
    }
    
    @discardableResult
    public func trackState(_ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.change = { action(self, $0) }
        return self
    }
    
    @discardableResult
    public func trackState(_ state: State<UIGestureRecognizer.State>) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.change = {
            state.wrappedValue = $0
        }
        return self
    }
    
    @discardableResult
    public func onPossible(_ action: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.possible = { action(self) }
        return self
    }
    
    @discardableResult
    public func onBegan(_ action: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.began = { action(self) }
        return self
    }
    
    @discardableResult
    public func onChanged(_ action: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.changed = { action(self) }
        return self
    }
    
    @discardableResult
    public func onEnded(_ action: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.ended = { action(self) }
        return self
    }
    
    @discardableResult
    public func onCancelled(_ action: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.cancelled = { action(self) }
        return self
    }
    
    @discardableResult
    public func onFailed(_ action: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.failed = { action(self) }
        return self
    }
    
    @discardableResult
    public func delegate(_ object: UIGestureRecognizerDelegate) -> Self {
        guard let s = self as? _GestureTrackable else { return self }
        s._tracker.outerDelegate = object
        return self
    }
}

// for iOS lower than 13
extension _GestureTrackable {
    @discardableResult
    public func trackState(_ action: @escaping (UIGestureRecognizer.State) -> Void) -> Self {
        _tracker.change = action
        return self
    }
    
    @discardableResult
    public func trackState(_ action: @escaping (UIGestureRecognizer.State, Self) -> Void) -> Self {
        _tracker.change = {
            action($0, self)
        }
        return self
    }
    
    @discardableResult
    public func trackState(_ action: @escaping (Self, UIGestureRecognizer.State) -> Void) -> Self {
        _tracker.change = { action(self, $0) }
        return self
    }
    
    @discardableResult
    public func trackState(_ state: State<UIGestureRecognizer.State>) -> Self {
        _tracker.change = {
            state.wrappedValue = $0
        }
        return self
    }
    
    @discardableResult
    public func onPossible(_ action: @escaping (Self) -> Void) -> Self {
        _tracker.possible = { action(self) }
        return self
    }
    
    @discardableResult
    public func onBegan(_ action: @escaping (Self) -> Void) -> Self {
        _tracker.began = { action(self) }
        return self
    }
    
    @discardableResult
    public func onChanged(_ action: @escaping (Self) -> Void) -> Self {
        _tracker.changed = { action(self) }
        return self
    }
    
    @discardableResult
    public func onEnded(_ action: @escaping (Self) -> Void) -> Self {
        _tracker.ended = { action(self) }
        return self
    }
    
    @discardableResult
    public func onCancelled(_ action: @escaping (Self) -> Void) -> Self {
        _tracker.cancelled = { action(self) }
        return self
    }
    
    @discardableResult
    public func onFailed(_ action: @escaping (Self) -> Void) -> Self {
        _tracker.failed = { action(self) }
        return self
    }
    
    @discardableResult
    public func delegate(_ object: UIGestureRecognizerDelegate) -> Self {
        _tracker.outerDelegate = object
        return self
    }
}
