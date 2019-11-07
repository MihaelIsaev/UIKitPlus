import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func tag(_ value: Int) -> Self {
        declarativeView.tag = value
        return self
    }
}
