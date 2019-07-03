import UIKit

extension DeclarativeProtocol {
    func movedToSuperview() {
        guard let superview = declarativeView.superview else { return }
        NSLayoutConstraint.Attribute.all.forEach { side in
            if _declarativeView._constraints[side] == nil {
                if let solo = _declarativeView._preConstraints.solo[side] {
                    activateSolo(superview: superview, preConstraint: solo, side: side)
                } else if let `super` = _declarativeView._preConstraints.super[side] {
                    activateSuper(superview: superview, preConstraint: `super`, side: side)
                } else if let relative = _declarativeView._preConstraints.relative[side] {
                    activateRelative(superview: superview, preConstraint: relative, side: side)
                }
            }
        }
    }
}
