import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
public typealias BaseViewController = NSViewController
#else
public typealias BaseViewController = UIViewController
#endif

#if os(macOS)
extension ViewController: _Menuable {
    func _setMenu(_ v: Menu) {
        view.menu = v.menu
    }
}
#endif

open class ViewController: BaseViewController {
    #if !os(macOS)
    #if !os(tvOS)
    open override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle.rawValue }
    #endif
    /// UIKitPlus reimplementation of `preferredStatusBarStyle`
    open var statusBarStyle: StatusBarStyle { _statusBarStyle ?? .default }
    #endif
    
    #if os(macOS)
    open override func loadView() {
        self.view = View()
    }
    
    public var navigationController: NavigationController?
    #endif
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(nibName: nil, bundle: nil)
        _setup()
        body { block() }
    }
    
    public init () {
        super.init(nibName: nil, bundle: nil)
        _setup()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _setup()
    }
    
    private func _setup() {
        #if !os(macOS)
        subscribeToKeyboardNotifications()
        #endif
        body { body }
        buildUI()
    }
    
    @ViewBuilder open var body: ViewBuilder.Result { [] }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    #if os(macOS)
    public func shakeWindow(numberOfShakes: Int = 4, intensity: CGFloat = 0.05, duration: Double = 0.6) {
        window?.shake(numberOfShakes: numberOfShakes, intensity: intensity, duration: duration)
    }
    
    public var window: NSWindow? { view.window }
    #endif
    
    #if !os(macOS)
    // MARK: Touches
    
    typealias TouchClosure = (Set<UITouch>, UIEvent?) -> Void
    
    var _touchesBegan: TouchClosure?
    var _touchesMoved: TouchClosure?
    var _touchesEnded: TouchClosure?
    var _touchesCancelled: TouchClosure?
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _touchesBegan?(touches, event)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        _touchesMoved?(touches, event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        _touchesEnded?(touches, event)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        _touchesCancelled?(touches, event)
    }
    #endif
    
    // MARK: Lifecycle
    
    open func buildUI() {
        #if !os(macOS)
        view.backgroundColor = .white
        #endif
    }
    
    public var isWillAppearedOnce = false
    public var isDidAppearedOnce = false
    
    #if os(macOS)
    var _viewDidLoad = {}
    var _viewDidLayout = {}
    var _viewDidAppear = {}
    var _viewDidAppearFirstTime = {}
    var _viewWillAppear = {}
    var _viewWillAppearFirstTime = {}
    var _viewWillDisappear = {}
    var _viewDidDisappear = {}
    #else
    var _viewDidLoad = {}
    var _viewDidLayoutSubviews = {}
    var _viewDidAppear: (Bool) -> Void = { _ in }
    var _viewDidAppearFirstTime: (Bool) -> Void = { _ in }
    var _viewWillAppear: (Bool) -> Void = { _ in }
    var _viewWillAppearFirstTime: (Bool) -> Void = { _ in }
    var _viewWillDisappear: (Bool) -> Void = { _ in }
    var _viewDidDisappear: (Bool) -> Void = { _ in }
    #endif
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        _viewDidLoad()
    }
    
    #if os(macOS)
    open override func viewDidLayout() {
        super.viewDidLayout()
        _viewDidLayout()
    }
    
    open override func viewDidAppear() {
        super.viewDidAppear()
        if !isDidAppearedOnce {
            isDidAppearedOnce = true
            viewDidAppearFirstTime()
        }
        _viewDidAppear()
    }
    
    open override func viewWillAppear() {
        super.viewWillAppear()
        #if !os(macOS)
        isSubscribedToKeyboardNotifications = true
        #endif
        if !isWillAppearedOnce {
            isWillAppearedOnce = true
            viewWillAppearFirstTime()
        }
        _viewWillAppear()
    }
    
    open override func viewWillDisappear() {
        super.viewWillDisappear()
        #if !os(macOS)
        isSubscribedToKeyboardNotifications = false
        #endif
        _viewWillDisappear()
    }
    
    open override func viewDidDisappear() {
        super.viewDidDisappear()
        _viewDidDisappear()
    }
    
    open func viewWillAppearFirstTime() {
        _viewDidAppearFirstTime()
    }
    open func viewDidAppearFirstTime() {
        _viewWillAppearFirstTime()
    }
    #else
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _viewDidLayoutSubviews()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isDidAppearedOnce {
            isDidAppearedOnce = true
            viewDidAppearFirstTime(animated)
        }
        _viewDidAppear(animated)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isSubscribedToKeyboardNotifications = true
        if !isWillAppearedOnce {
            isWillAppearedOnce = true
            viewWillAppearFirstTime(animated)
        }
        _viewWillAppear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isSubscribedToKeyboardNotifications = false
        _viewWillDisappear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _viewDidDisappear(animated)
    }
    
    open func viewWillAppearFirstTime(_ animated: Bool) {
        _viewDidAppearFirstTime(animated)
    }
    open func viewDidAppearFirstTime(_ animated: Bool) {
        _viewWillAppearFirstTime(animated)
    }
    
    @State public var keyboardHeight: CGFloat = 0
    
    private var isSubscribedToKeyboardNotifications = false
    
    private func subscribeToKeyboardNotifications() {
        #if !os(tvOS)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        #endif
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
    
    var _statusBarStyle: StatusBarStyle?
    
    @discardableResult
    public func statusBarStyle(_ value: StatusBarStyle) -> Self {
        _statusBarStyle = value
        return self
    }
    
    @discardableResult
    public func navigationItem(_ closure: (Self, UINavigationItem) -> Void) -> Self {
        closure(self, navigationItem)
        return self
    }
    
    @discardableResult
    public func navigationController(_ closure: (Self, UINavigationController?) -> Void) -> Self {
        closure(self, navigationController)
        return self
    }
    #endif
}

// MARK: Lifecycle

extension ViewController {
    /// didLoad
    @discardableResult
    public func onViewDidLoad(_ closure: @escaping () -> Void) -> Self {
        _viewDidLoad = closure
        return self
    }
    
    @discardableResult
    public func onViewDidLoad(_ closure: @escaping (Self) -> Void) -> Self {
        _viewDidLoad = {
            closure(self)
        }
        return self
    }
    
    #if os(macOS)
    /// didLayout
    @discardableResult
    public func onViewDidLayout(_ closure: @escaping () -> Void) -> Self {
        _viewDidLayout = closure
        return self
    }
    
    @discardableResult
    public func onViewDidLayout(_ closure: @escaping (Self) -> Void) -> Self {
        _viewDidLayout = {
            closure(self)
        }
        return self
    }
    #else
    /// didLayoutSubviews
    @discardableResult
    public func onViewDidLayoutSubviews(_ closure: @escaping () -> Void) -> Self {
        _viewDidLayoutSubviews = closure
        return self
    }
    
    @discardableResult
    public func onViewDidLayoutSubviews(_ closure: @escaping (Self) -> Void) -> Self {
        _viewDidLayoutSubviews = {
            closure(self)
        }
        return self
    }
    #endif
    
    
    /// didAppearFirstTime
    @discardableResult
    public func onViewDidAppearFirstTime(_ closure: @escaping () -> Void) -> Self {
        #if os(macOS)
        _viewDidAppearFirstTime = {
            closure()
        }
        #else
        _viewDidAppearFirstTime = { a in
            closure()
        }
        #endif
        return self
    }
    
    @discardableResult
    public func onViewDidAppearFirstTime(_ closure: @escaping (Self) -> Void) -> Self {
        #if os(macOS)
        _viewDidAppearFirstTime = {
            closure(self)
        }
        #else
        _viewDidAppearFirstTime = { a in
            closure(self)
        }
        #endif
        return self
    }
    
    #if !os(macOS)
    @discardableResult
    public func onViewDidAppearFirstTime(_ closure: @escaping (Self, Bool) -> Void) -> Self {
        _viewDidAppearFirstTime = { a in
            closure(self, a)
        }
        return self
    }
    #endif
    
    /// willAppear
    @discardableResult
    public func onViewWillAppear(_ closure: @escaping () -> Void) -> Self {
        #if os(macOS)
        _viewWillAppear = {
            closure()
        }
        #else
        _viewWillAppear = { a in
            closure()
        }
        #endif
        return self
    }
    
    @discardableResult
    public func onViewWillAppear(_ closure: @escaping (Self) -> Void) -> Self {
        #if os(macOS)
        _viewWillAppear = {
            closure(self)
        }
        #else
        _viewWillAppear = { a in
            closure(self)
        }
        #endif
        return self
    }
    
    #if !os(macOS)
    @discardableResult
    public func onViewWillAppear(_ closure: @escaping (Self, Bool) -> Void) -> Self {
        _viewWillAppear = { a in
            closure(self, a)
        }
        return self
    }
    #endif
    
    /// willAppearFirstTime
    @discardableResult
    public func onViewWillAppearFirstTime(_ closure: @escaping () -> Void) -> Self {
        #if os(macOS)
        _viewWillAppearFirstTime = {
            closure()
        }
        #else
        _viewWillAppearFirstTime = { a in
            closure()
        }
        #endif
        return self
    }
    
    @discardableResult
    public func onViewWillAppearFirstTime(_ closure: @escaping (Self) -> Void) -> Self {
        #if os(macOS)
        _viewWillAppearFirstTime = {
            closure(self)
        }
        #else
        _viewWillAppearFirstTime = { a in
            closure(self)
        }
        #endif
        return self
    }
    
    #if !os(macOS)
    @discardableResult
    public func onViewWillAppearFirstTime(_ closure: @escaping (Self, Bool) -> Void) -> Self {
        _viewWillAppearFirstTime = { a in
            closure(self, a)
        }
        return self
    }
    #endif
    
    /// willDisappear
    @discardableResult
    public func onViewWillDisappear(_ closure: @escaping () -> Void) -> Self {
        #if os(macOS)
        _viewWillDisappear = {
            closure()
        }
        #else
        _viewWillDisappear = { a in
            closure()
        }
        #endif
        return self
    }
    
    @discardableResult
    public func onViewWillDisappear(_ closure: @escaping (Self) -> Void) -> Self {
        #if os(macOS)
        _viewWillDisappear = {
            closure(self)
        }
        #else
        _viewWillDisappear = { a in
            closure(self)
        }
        #endif
        return self
    }
    
    #if !os(macOS)
    @discardableResult
    public func onViewWillDisappear(_ closure: @escaping (Self, Bool) -> Void) -> Self {
        _viewWillDisappear = { a in
            closure(self, a)
        }
        return self
    }
    #endif
    
    /// didDisappear
    @discardableResult
    public func onViewDidDisappear(_ closure: @escaping () -> Void) -> Self {
        #if os(macOS)
        _viewDidDisappear = {
            closure()
        }
        #else
        _viewDidDisappear = { a in
            closure()
        }
        #endif
        return self
    }
    
    @discardableResult
    public func onViewDidDisappear(_ closure: @escaping (Self) -> Void) -> Self {
        #if os(macOS)
        _viewDidDisappear = {
            closure(self)
        }
        #else
        _viewDidDisappear = { a in
            closure(self)
        }
        #endif
        return self
    }
    
    #if !os(macOS)
    @discardableResult
    public func onViewDidDisappear(_ closure: @escaping (Self, Bool) -> Void) -> Self {
        _viewDidDisappear = { a in
            closure(self, a)
        }
        return self
    }
    #endif
}

// MARK: Titleable

extension BaseViewController: _Titleable {
    var _statedTitle: AnyStringBuilder.Handler? {
        get { nil }
        set {}
    }
    #if !os(macOS)
    var _titleChangeTransition: UIView.AnimationOptions? {
        get { nil }
        set {}
    }
    #endif
    
    func _setTitle(_ v: NSAttributedString?) {
        self.title = v?.string
    }
}

#if !os(macOS)
extension BaseViewController: _BackgroundColorable {
    func _setBackgroundColor(_ v: UColor) {
        view.backgroundColor = v
    }
}
#endif

// MARK: Keyboard Notifications
#if !os(tvOS) && !os(macOS)
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
#endif

#if !os(macOS)
// MARK: Touches

extension ViewController {
    /// Began
    @discardableResult
    public func touchesBegan(_ closure: @escaping () -> Void) -> Self {
        _touchesBegan = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesBegan = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesBegan = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesBegan = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Moved
    @discardableResult
    public func touchesMoved(_ closure: @escaping () -> Void) -> Self {
        _touchesMoved = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesMoved = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesMoved = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesMoved = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Ended
    @discardableResult
    public func touchesEnded(_ closure: @escaping () -> Void) -> Self {
        _touchesEnded = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesEnded = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesEnded = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesEnded = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Cancelled
    @discardableResult
    public func touchesCancelled(_ closure: @escaping () -> Void) -> Self {
        _touchesCancelled = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesCancelled = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesCancelled = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesCancelled = { set, event in
            closure(self, set, event)
        }
        return self
    }
}
#endif
