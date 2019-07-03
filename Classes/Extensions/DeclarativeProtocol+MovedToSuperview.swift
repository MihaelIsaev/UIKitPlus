import UIKit

extension DeclarativeProtocol {
    func movedToSuperview() {
        guard let superview = declarativeView.superview else { return }
        NSLayoutConstraint.Attribute.all.forEach { side in
            if _declarativeView._constraints[side] == nil || _declarativeView._constraints[side]?.isActive == false {
                if let solo = _declarativeView._preConstraints.solo[side] {
                    activateSolo(superview: superview, preConstraint: solo, side: side)
                } else if let `super` = _declarativeView._preConstraints.super[side] {
                    activateRelative(side, to: superview, side: side, preConstraint: `super`)
                } else if let relative = _declarativeView._preConstraints.relative[side] {
                    switch side {
                    case .width, .height:
                        if let to = relative.dSide {
                            activateRelative(side, to: to.view, side: to.side.side, preConstraint: relative)
                        } else {
                            #if DEBUG
                            print("⚠️ Unable to activate relative dSide constraint on `movedToSuperview`")
                            #endif
                        }
                    case .top, .bottom, .centerY:
                        if let to = relative.ySide {
                            activateRelative(side, to: to.view, side: to.side.side, preConstraint: relative)
                        } else {
                            #if DEBUG
                            print("⚠️ Unable to activate relative ySide constraint on `movedToSuperview`")
                            #endif
                        }
                    case .leading, .trailing, .centerX:
                        if let to = relative.xSide {
                            activateRelative(side, to: to.view, side: to.side.side, preConstraint: relative)
                        } else {
                            #if DEBUG
                            print("⚠️ Unable to activate relative xSide constraint on `movedToSuperview`")
                            #endif
                        }
                    default: break
                    }
                }
            }
        }
    }
}
