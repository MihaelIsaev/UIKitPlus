import UIKit

typealias DeclarativeConstraintsCollection = [NSLayoutConstraint.Attribute: NSLayoutConstraint]
typealias ViewConstraintDictionary = [UIView: NSLayoutConstraint]
typealias DeclarativeConstraintsKeyValueCollection = [NSLayoutConstraint.Attribute: ViewConstraintDictionary]

extension Dictionary where Key == NSLayoutConstraint.Attribute, Value: NSLayoutConstraint {
    func isNotActive(_ key: Key) -> Bool {
        return self[key] == nil || self[key]?.isActive == false
    }
    
    mutating func setValue(_ value: Value?, for key: Key) {
        guard let value = value else {
            removeValue(for: key)
            return
        }
        self[key] = value
    }
    
    mutating func setValue(_ value: CGFloat?, for key: Key) {
        guard let value = value else {
            removeValue(for: key)
            return
        }
        self[key]?.constant = value
    }
    
    mutating func removeValue(for key: Key) {
        self[key]?.isActive = false
        removeValue(forKey: key)
    }
}

extension Dictionary where Key == NSLayoutConstraint.Attribute, Value == DeclarativePreConstraints.RelativeConstraints {
    mutating func setValue(side: Key, value: ConstraintValueType, forKey key: Key, andView view: UIView) {
        if self[side] == nil {
            self[side] = [view: [key: value]]
        } else if self[key]?[view] == nil {
            self[side]?[view] = [key: value]
        } else {
            self[side]?[view]?[key] = value
        }
    }
    
    mutating func removeValue(forKey key: Key, andView view: UIView) {
        self[key]?[view]?.removeValue(forKey: key)
        return
    }
}

extension Dictionary where Key == NSLayoutConstraint.Attribute, Value == ViewConstraintDictionary {
    func isNotActive(_ key: Key, _ view: UIView) -> Bool {
        self[key]?[view] == nil || self[key]?[view]?.isActive == false
    }
    
    mutating func setValue(_ value: NSLayoutConstraint?, forKey key: Key, andView view: UIView) {
        guard let value = value else {
            removeValue(forKey: key, andView: view)
            return
        }
        if self[key] == nil {
            self[key] = [view: value]
        } else if self[key]?[view] == nil {
            self[key]?[view] = value
        }
    }
    
    mutating func setValue(_ value: CGFloat?, forKey key: Key, andView view: UIView) {
        guard let value = value else {
            removeValue(forKey: key, andView: view)
            return
        }
        self[key]?[view]?.constant = value
    }
    
    mutating func removeValue(forKey key: Key, andView view: UIView) {
        self[key]?[view]?.isActive = false
        self[key]?.removeValue(forKey: view)
        return
    }
}
