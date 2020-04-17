import Foundation
import UIKit

open class ViewController: UIViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle.rawValue }
    /// UIKitPlus reimplementation of `preferredStatusBarStyle`
    open var statusBarStyle: StatusBarStyle { .default }
    
    @State public var keyboardHeight: CGFloat = 0
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(nibName: nil, bundle: nil)
        subscribeToKeyboardNotifications()
        buildUI()
        body { block().viewBuilderItems }
    }
    
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
    
    open func keyboardAppeared(_ height: CGFloat, _ animationDuration: TimeInterval, _ animationCurve: UIView.AnimationCurve?, _ options: UIView.AnimationOptions, _ inThisController: Bool) {
        keyboardWasShownAtLeastOnce = true
        if inThisController {
            if #available(iOS 11.0, *) {
                UIViewPropertyAnimator(duration: animationDuration, curve: animationCurve ?? .linear) {
                    self.keyboardHeight = height
                    self.view.layoutIfNeeded()
                }.startAnimation()
            } else {
                self.keyboardHeight = height
                UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    open func keyboardDisappeared(_ animationDuration: TimeInterval, _ animationCurve: UIView.AnimationCurve?, _ options: UIView.AnimationOptions, _ inThisController: Bool) -> Bool {
        guard keyboardWasShownAtLeastOnce else { return false }
        if inThisController {
            if #available(iOS 11.0, *) {
                UIViewPropertyAnimator(duration: animationDuration, curve: animationCurve ?? .linear) {
                    self.keyboardHeight = 0
                    self.view.layoutIfNeeded()
                }.startAnimation()
            } else {
                self.keyboardHeight = 0
                UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
        return true
    }
    
    /// Call it to disable the interactive dismissal of presented view controller in iOS 13
    @discardableResult
    public func modalInPresentation(_ value: Bool = true) -> Self {
        if #available(iOS 13.0, *) {
            isModalInPresentation = value
        }
        return self
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
        guard let animationCurveUInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurveUInt)
        let animationCurve = UIView.AnimationCurve(rawValue: Int(animationCurveUInt))
        keyboardAppeared(keyboardRectangle.height, animationDuration, animationCurve, animationOptions, isSubscribedToKeyboardNotifications)
    }
    
    @objc
    private func keyboardWillDisappear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let animationCurveUInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurveUInt)
        let animationCurve = UIView.AnimationCurve(rawValue: Int(animationCurveUInt))
        _ = keyboardDisappeared(animationDuration, animationCurve, animationOptions, isSubscribedToKeyboardNotifications)
    }
}
