import UIKit

extension DeclarativeProtocol {
    func movedToSuperview() {
        guard let superview = declarativeView.superview else { return }
        NSLayoutConstraint.Attribute.all.forEach { side in
            if let solo = _declarativeView._preConstraints.solo[side] {
                if _declarativeView._constraintsMain.isNotActive(side) {
                    activateSolo(preConstraint: solo, side: side)
                }
            } else if let `super` = _declarativeView._preConstraints.super[side] {
                if _declarativeView._constraintsMain.isNotActive(side) {
                    activateSuper(side, to: superview, side: side, preConstraint: `super`)
                }
            } else if let relative = _declarativeView._preConstraints.relative[side] {
                relative.forEach { view, constraintsKeyValue in
                    constraintsKeyValue.forEach { key, value in
                        if _declarativeView._constraintsOuter.isNotActive(key, view) {
                            activateRelative(side, to: view, side: key, preConstraint: .init(attribute1: side, attribute2: key, value: value))
                        }
                    }
                }
            }
        }
    }
}
