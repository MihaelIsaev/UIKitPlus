import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func tint(_ color: UIColor) -> Self {
        declarativeView.tintColor = color
        return self
    }
    
    @discardableResult
    public func tint(_ number: Int) -> Self {
        declarativeView.tintColor = number.color
        return self
    }
}
