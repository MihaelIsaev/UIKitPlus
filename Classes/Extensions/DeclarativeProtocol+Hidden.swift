import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func hidden(_ hidden: Bool = true) -> Self {
        declarativeView.isHidden = hidden
        return self
    }
}
