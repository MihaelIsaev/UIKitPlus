import UIKit

extension DeclarativeProtocol {
    public func focusToNextResponderOrResign() {
        if let nextResponder = declarativeView.viewWithTagInSuperview(declarativeView.tag + 1) {
            nextResponder.becomeFirstResponder()
        } else {
            declarativeView.resignFirstResponder()
        }
    }
}
