import UIKit

extension NSLayoutConstraint {
    @discardableResult
    func activated() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
