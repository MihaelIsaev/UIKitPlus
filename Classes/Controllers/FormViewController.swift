import UIKit

open class FormViewController: ViewController {
    public lazy var scrollView = ScrollView()
    public lazy var stackView = StackView().axis(.vertical)
    
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    open override func buildUI() {
        super.buildUI()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        topConstraint = scrollView.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 0)
        bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([
            topConstraint!,
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeArea.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeArea.trailingAnchor, constant: 0),
            bottomConstraint!,
            stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: 0)
            ])
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
        bottomConstraint?.constant = height
        view.layoutIfNeeded()
    }
    
    func keyboardDisappeared(_ animationDuration: TimeInterval) -> Bool {
        guard keyboardWasShowedAtLeastOnce else { return false }
        bottomConstraint?.constant = 0
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
