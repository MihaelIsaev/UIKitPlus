#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    @discardableResult
    public func compressionResistance(x value: UILayoutPriority) -> Self {
        #if !os(macOS)
        declarativeView.setContentCompressionResistancePriority(value, for: .horizontal)
        #endif
        return self
    }
    
    @discardableResult
    public func compressionResistance(y value: UILayoutPriority) -> Self {
        #if !os(macOS)
        declarativeView.setContentCompressionResistancePriority(value, for: .vertical)
        #endif
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
