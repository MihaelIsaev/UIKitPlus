import UIKit

extension NSLayoutConstraint {
    func activated() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
