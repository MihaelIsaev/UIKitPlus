import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func hidden(_ hidden: Bool) -> Self {
        declarativeView.isHidden = hidden
        return self
    }
}
