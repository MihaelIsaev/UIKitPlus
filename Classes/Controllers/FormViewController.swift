import UIKit

open class FormViewController: ViewController {
    public lazy var scrollView = ScrollView().edgesToSuperview()
    public lazy var stackView = VStackView().edgesToSuperview().width(to: .width, of: scrollView)
    
    open override func buildUI() {
        super.buildUI()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    public override init() {
        super.init()
        subscribeToKeyboardNotifications()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        subscribeToKeyboardNotifications()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var keyboardWasShowedAtLeastOnce = false
    
    func keyboardAppeared(_ height: CGFloat, _ animationDuration: TimeInterval) {
        keyboardWasShowedAtLeastOnce = true
        scrollView.bottom = height * (-1)
        view.layoutIfNeeded()
    }
    
    func keyboardDisappeared(_ animationDuration: TimeInterval) -> Bool {
        guard keyboardWasShowedAtLeastOnce else { return false }
        scrollView.bottom = 0
        view.layoutIfNeeded()
        return true
    }
}

// MARK: Keyboard Notifications

extension FormViewController {
    @objc
    private func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        guard keyboardRectangle.height > 0 else { return }
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        keyboardAppeared(keyboardRectangle.height, animationDuration)
    }
    
    @objc
    private func keyboardWillDisappear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        _ = keyboardDisappeared(animationDuration)
    }
}
