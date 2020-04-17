//
//  Toucheable.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 17.04.2020.
//

import UIKit

public typealias TouchClosure = (Set<UITouch>, UIEvent?) -> Void

public protocol Toucheable: class {
    @discardableResult
    func touchesBegan(_ closure: @escaping TouchClosure) -> Self
    
    @discardableResult
    func touchesMoved(_ closure: @escaping TouchClosure) -> Self
    
    @discardableResult
    func touchesEnded(_ closure: @escaping TouchClosure) -> Self
    
    @discardableResult
    func touchesCancelled(_ closure: @escaping TouchClosure) -> Self
}

protocol _Toucheable: Toucheable {
    var _touchesBegan: TouchClosure? { get set }
    var _touchesMoved: TouchClosure? { get set }
    var _touchesEnded: TouchClosure? { get set }
    var _touchesCancelled: TouchClosure? { get set }
}

@available(iOS 13.0, *)
extension Toucheable {
    /// Began
    @discardableResult
    public func touchesBegan(_ closure: @escaping () -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesBegan = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesBegan = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesBegan = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesBegan = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Moved
    @discardableResult
    public func touchesMoved(_ closure: @escaping () -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesMoved = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesMoved = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesMoved = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesMoved = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Ended
    @discardableResult
    public func touchesEnded(_ closure: @escaping () -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesEnded = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesEnded = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesEnded = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesEnded = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Cancelled
    @discardableResult
    public func touchesCancelled(_ closure: @escaping () -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesCancelled = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesCancelled = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesCancelled = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        guard let s = self as? _Toucheable else { return self }
        s._touchesCancelled = { set, event in
            closure(self, set, event)
        }
        return self
    }
}

// for iOS lower than 13
extension _Toucheable {
    /// Began
    @discardableResult
    public func touchesBegan(_ closure: @escaping () -> Void) -> Self {
        _touchesBegan = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesBegan = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesBegan = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesBegan = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Moved
    @discardableResult
    public func touchesMoved(_ closure: @escaping () -> Void) -> Self {
        _touchesMoved = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesMoved = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesMoved = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesMoved = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Ended
    @discardableResult
    public func touchesEnded(_ closure: @escaping () -> Void) -> Self {
        _touchesEnded = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesEnded = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesEnded = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesEnded = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Cancelled
    @discardableResult
    public func touchesCancelled(_ closure: @escaping () -> Void) -> Self {
        _touchesCancelled = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesCancelled = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesCancelled = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesCancelled = { set, event in
            closure(self, set, event)
        }
        return self
    }
}
