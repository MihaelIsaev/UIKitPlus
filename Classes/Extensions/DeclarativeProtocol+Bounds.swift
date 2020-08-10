#if !os(macOS)
import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func clipsToBounds(_ value: Bool = true) -> Self {
        declarativeView.clipsToBounds = value
        return self
    }
    
    @discardableResult
    public func masksToBounds(_ value: Bool = true) -> Self {
        declarativeView.layer.masksToBounds = value
        return self
    }
}
#endif
