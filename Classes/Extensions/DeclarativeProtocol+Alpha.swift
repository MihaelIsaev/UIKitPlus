import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        declarativeView.alpha = alpha
        return self
    }
}
