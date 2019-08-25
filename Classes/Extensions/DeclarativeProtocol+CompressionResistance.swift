import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func compressionResistance(x value: UILayoutPriority) -> Self {
        declarativeView.setContentCompressionResistancePriority(value, for: .horizontal)
        return self
    }
    
    @discardableResult
    public func compressionResistance(y value: UILayoutPriority) -> Self {
        declarativeView.setContentCompressionResistancePriority(value, for: .vertical)
        return self
    }
    
    @discardableResult
    public func compressionResistance(x value: Float) -> Self {
        declarativeView.setContentCompressionResistancePriority(.init(value), for: .horizontal)
        return self
    }
    
    @discardableResult
    public func compressionResistance(y value: Float) -> Self {
        declarativeView.setContentCompressionResistancePriority(.init(value), for: .vertical)
        return self
    }
}
