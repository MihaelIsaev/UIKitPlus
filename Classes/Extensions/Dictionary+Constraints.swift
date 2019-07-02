import UIKit

typealias DeclarativeConstraintsCollection = [NSLayoutConstraint.Attribute: NSLayoutConstraint]

extension Dictionary where Key == NSLayoutConstraint.Attribute, Value: NSLayoutConstraint {
    mutating func setValue(_ value: Value?, for key: Key) {
        if value == nil {
            self[key]?.isActive = false
        }
        self[key] = value
    }
    
    mutating func setValue(_ value: CGFloat?, for key: Key) {
        guard let value = value else {
            self[key]?.isActive = false
            removeValue(forKey: key)
            return
        }
        self[key]?.constant = value
    }
    
    mutating func removeValue(for key: Key) {
        self[key]?.isActive = false
        removeValue(forKey: key)
    }
}
