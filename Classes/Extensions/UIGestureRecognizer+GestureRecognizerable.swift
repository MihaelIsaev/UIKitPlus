import UIKit

extension UIGestureRecognizer: _GestureRecognizerable {
    func _setDelegate(_ v: UIGestureRecognizerDelegate) {
        delegate = v
    }
    
    func _setEnabled(_ v: Bool) {
        isEnabled = v
    }
    
    func _setCancelsTouchesInView(_ v: Bool) {
        cancelsTouchesInView = v
    }
    
    func _setDelaysTouchesBegan(_ v: Bool) {
        delaysTouchesBegan = v
    }
    
    func _setDelaysTouchesEnded(_ v: Bool) {
        delaysTouchesEnded = v
    }
    
    func _setName(_ v: String) {
        if #available(iOSApplicationExtension 11.0, *) {
            name = v
        }
    }
    
    func _setRequiresExclusiveTouchType(_ v: Bool) {
        if #available(iOSApplicationExtension 9.2, *) {
            requiresExclusiveTouchType = v
        }
    }
    
    func _setAllowedTouchTypes(_ v: [NSNumber]) {
        allowedTouchTypes = v
    }
    
    func _setAllowedPressTypes(_ v: [NSNumber]) {
        allowedPressTypes = v
    }
    
    func _setRequireToFailOtherGestureRecognizer(_ v: UIGestureRecognizer) {
        require(toFail: v)
    }
}
