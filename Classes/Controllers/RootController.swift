import UIKit

public typealias RootSimpleCompletion = () -> Void
public typealias RootBeforeTransition = (UIViewController) -> Void

public typealias SimpleRootController = RootController<Never>

open class RootController<DeeplinkType>: ViewController, RootControllerable {
    open override var preferredStatusBarStyle: UIStatusBarStyle { current.preferredStatusBarStyle }
    
    public internal(set) var current: UIViewController = .init()
    
    @State public var currentType: RootScreenType = .nothing
    
    public var deeplink: DeeplinkType? {
        didSet {
            if let deeplink = deeplink {
                handleDeepLink(type: deeplink)
            }
        }
    }
    
    open var splashScreen: UIViewController { NotImplementedViewController("splashScreen") }
    open var loginScreen: UIViewController { NotImplementedViewController("loginScreen") }
    open var logoutScreen: UIViewController { NotImplementedViewController("logoutScreen") }
    open var mainScreen: UIViewController { NotImplementedViewController("mainScreen") }
    open var onboardingScreen: UIViewController? { nil }
    
    /// By default shows `splashScreen`
    open var initialScreen: UIViewController { splashScreen }
    
    open var shouldShowOnboardingBeforeMainScreen: Bool { return true }
    
    required public override init() {
        super.init(nibName:  nil, bundle: nil)
        current = initialScreen
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        addChild(current)
        current.view.frame = view.bounds
        view.body { current.view }
        current.didMove(toParent: self)
    }
    
    open func showLoginScreen() {
        if currentType == .login {
            print("⚠️ Don't show login twice")
            return
        }
        currentType = .login
        replaceWithoutAnimation(loginScreen)
    }
    
    @discardableResult
    open func showOnboardingScreen() -> Bool {
        guard let new = onboardingScreen else { return false }
        if currentType == .onboarding {
            print("⚠️ Don't show onboarding twice")
            return false
        }
        currentType = .onboarding
        replaceWithoutAnimation(new)
        return true
    }
    
    open func switchToLogout(beforeTransition: RootBeforeTransition? = nil, completion: RootSimpleCompletion? = nil) {
        if currentType == .logout {
            print("⚠️ Don't call switch to logout twice")
            return
        }
        currentType = .logout
        let logoutScreen = self.logoutScreen
        beforeTransition?(logoutScreen)
        animateDismissTransition(to: logoutScreen) {
            self.currentType = .login
            completion?()
        }
    }
    
    open func switchToMainScreen(beforeTransition: RootBeforeTransition? = nil, completion: RootSimpleCompletion? = nil) {
        if currentType == .main {
            print("⚠️ Don't call switch to main screen twice")
            return
        }
        if shouldShowOnboardingBeforeMainScreen, showOnboardingScreen() { return }
        currentType = .main
        let mainScreen = self.mainScreen
        beforeTransition?(mainScreen)
        animateFadeTransition(to: mainScreen) { [weak self] in
            if let deeplink = self?.deeplink {
                self?.handleDeepLink(type: deeplink)
            }
            completion?()
        }
    }
    
    public func `switch`(to: UIViewController, as: RootScreenType, animation: RootTransitionAnimation, completion: RootSimpleCompletion? = nil) {
        currentType = `as`
        switch animation {
        case .none:
            replaceWithoutAnimation(to)
            proceedDeeplink()
            completion?()
        case .fade:
            animateFadeTransition(to: to) {
                self.proceedDeeplink()
                completion?()
            }
        }
    }
    
    private func proceedDeeplink() {
        if let deeplink = self.deeplink {
            handleDeepLink(type: deeplink)
        }
    }
    
    private func replaceWithoutAnimation(_ new: UIViewController) {
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: RootSimpleCompletion? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        new.willMove(toParent: self)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {}) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: RootSimpleCompletion? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    open func handleDeepLink(type: DeeplinkType) {}
    
    public func attach(to window: UIWindow?) {
        window?.rootViewController = self
        window?.makeKeyAndVisible()
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    public func attach(to scene: UIScene) -> UIWindow? {
        guard let windowScene = scene as? UIWindowScene else { return nil }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = self
        window.makeKeyAndVisible()
        return window
    }
}
