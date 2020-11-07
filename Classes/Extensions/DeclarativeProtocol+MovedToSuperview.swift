#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    func movedToSuperview() {
        _declarativeView._properties.notAppliedPreConstraintsSolo.forEach(declarativeView.activateSolo)
        _declarativeView._properties.notAppliedPreConstraintsSuper.forEach(declarativeView.activateSuper)
        _declarativeView._properties.notAppliedPreConstraintsRelative.forEach(declarativeView.activateRelative)
        NotificationCenter.default.post(raw: AddedViewWithTag(tag))
    }
}
