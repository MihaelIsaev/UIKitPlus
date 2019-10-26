import UIKit

extension DeclarativeProtocol {
    func movedToSuperview() {
        guard let superview = declarativeView.superview else { return }
        debugPrint("movedToSuperview: supers: \(_declarativeView._properties.notAppliedPreConstraintsSuper.count)")
        _declarativeView._properties.notAppliedPreConstraintsSolo.forEach(declarativeView.activateSolo)
        _declarativeView._properties.notAppliedPreConstraintsSuper.forEach(declarativeView.activateSuper)
        _declarativeView._properties.notAppliedPreConstraintsRelative.forEach(declarativeView.activateRelative)
    }
}
