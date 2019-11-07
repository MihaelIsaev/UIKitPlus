import Foundation
import UIKit

open class ViewController: UIViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle.rawValue }
    /// UIKitPlus reimplementation of `preferredStatusBarStyle`
    open var statusBarStyle: StatusBarStyle { .default }
    
    @State
    public var keyboardHeight: CGFloat = 0
    
    public init () {
        super.init(nibName: nil, bundle: nil)
        subscribeToKeyboardNotifications()
        buildUI()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        subscribeToKeyboardNotifications()
        buildUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func buildUI() {
        view.backgroundColor = .white
    }
    
    public var isAppearedOnce = false
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isAppearedOnce {
            isAppearedOnce = true
            viewDidAppearFirstTime(animated)
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isSubscribedToKeyboardNotifications = true
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isSubscribedToKeyboardNotifications = false
    }
    
    open func viewDidAppearFirstTime(_ animated: Bool) {}
    
    private var isSubscribedToKeyboardNotifications = false
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var keyboardWasShownAtLeastOnce = false
    
    open func keyboardAppeared(_ height: CGFloat, _ animationDuration: TimeInterval, _ animationCurve: UIView.AnimationCurve?, _ inThisController: Bool) {
        keyboardWasShownAtLeastOnce = true
        if inThisController {
            if #available(iOS 10.0, *) {
                UIViewPropertyAnimator(duration: animationDuration, curve: animationCurve ?? .linear) {
                    self.keyboardHeight = height
                    self.view.layoutIfNeeded()
                }.startAnimation()
            } else {
                self.keyboardHeight = height
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    open func keyboardDisappeared(_ animationDuration: TimeInterval, _ animationCurve: UIView.AnimationCurve?, _ inThisController: Bool) -> Bool {
        guard keyboardWasShownAtLeastOnce else { return false }
        if inThisController {
            if #available(iOS 10.0, *) {
                UIViewPropertyAnimator(duration: animationDuration, curve: animationCurve ?? .linear) {
                    self.keyboardHeight = 0
                    self.view.layoutIfNeeded()
                }.startAnimation()
            } else {
                self.keyboardHeight = 0
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        return true
    }
}

// MARK: Keyboard Notifications

extension ViewController {
    @objc
    private func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        guard keyboardRectangle.height > 0 else { return }
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        var animationCurve: UIView.AnimationCurve?
        if let animationCurveInt = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue {
            animationCurve = UIView.AnimationCurve(rawValue: animationCurveInt)
        }
        keyboardAppeared(keyboardRectangle.height, animationDuration, animationCurve, isSubscribedToKeyboardNotifications)
    }
    
    @objc
    private func keyboardWillDisappear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        var animationCurve: UIView.AnimationCurve?
        if let animationCurveInt = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue {
            animationCurve = UIView.AnimationCurve(rawValue: animationCurveInt)
        }
        _ = keyboardDisappeared(animationDuration, animationCurve, isSubscribedToKeyboardNotifications)
    }
}
