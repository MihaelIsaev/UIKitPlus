import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func gesture(_ recognizer: UIGestureRecognizer) -> Self {
        declarativeView.addGestureRecognizer(recognizer)
        return self
    }
}
