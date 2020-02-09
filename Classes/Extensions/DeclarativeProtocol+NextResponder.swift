import UIKit

extension DeclarativeProtocol {
    public func focusToNextResponderOrResign() {
        let nextTag = declarativeView.tag + 1
        var nextResponder: UIView?
        if let view = declarativeView.superview?.viewWithTag(nextTag) {
            nextResponder = view
        } else if let view = declarativeView.superview?.superview?.viewWithTag(nextTag) {
            nextResponder = view
        } else if let view = declarativeView.superview?.superview?.superview?.viewWithTag(nextTag) {
            nextResponder = view
        } else if let view = declarativeView.superview?.superview?.superview?.superview?.viewWithTag(nextTag) {
            nextResponder = view
        } else if let view = declarativeView.superview?.superview?.superview?.superview?.superview?.viewWithTag(nextTag) {
            nextResponder = view
        }
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            declarativeView.resignFirstResponder()
        }
    }
}
