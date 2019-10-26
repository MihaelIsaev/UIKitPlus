import UIKit

extension DeclarativeProtocol {
    func movedToSuperview() {
        guard let superview = declarativeView.superview else { return }
        debugPrint("movedToSuperview: supers: \(_declarativeView._properties.notAppliedPreConstraintsSuper.count)")
        _declarativeView._properties.notAppliedPreConstraintsSuper.forEach(declarativeView.activateSuperNew)
        _declarativeView._properties.notAppliedPreConstraintsSolo.forEach(declarativeView.activateSolo)
        NSLayoutConstraint.Attribute.all.forEach { side in
            if let solo = _declarativeView._properties.preConstraints.solo[side] {
//                if _declarativeView._properties.constraintsMain.isNotActive(side) {
//                    declarativeView.activateSolo(preConstraint: solo, side: side)
//                }
            } else if let `super` = _declarativeView._properties.preConstraints.super[side] {
//                if _declarativeView._properties.constraintsMain.isNotActive(side) {
//                    declarativeView.activateSuper(side, to: superview, side: side, preConstraint: `super`)
//                }
            } else if let relative = _declarativeView._properties.preConstraints.relative[side] {
                relative.forEach { view, constraintsKeyValue in
                    constraintsKeyValue.forEach { key, value in
                        if _declarativeView._properties.constraintsOuter.isNotActive(key, view) {
                            declarativeView.activateRelative(side, to: view, side: key, preConstraint: .init(attribute1: side, attribute2: key, value: value))
                        }
                    }
                }
            }
        }
    }
}
