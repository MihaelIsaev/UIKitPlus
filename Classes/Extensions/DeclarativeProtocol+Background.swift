import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func background(_ color: UIColor) -> Self {
        declarativeView.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func background(_ number: Int) -> Self {
        declarativeView.backgroundColor = number.color
        return self
    }
}
