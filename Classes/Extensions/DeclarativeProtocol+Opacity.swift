import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
        declarativeView.layer.opacity = opacity
        return self
    }
}
