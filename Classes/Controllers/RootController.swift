import UIKit

public typealias RootSimpleCompletion = () -> Void
public typealias RootBeforeTransition = (UIViewController) -> Void

public typealias SimpleRootController = RootController<Never>

open class RootController<DeeplinkType>: ViewController, RootControllerable {
    #if !os(tvOS)
    open override var preferredStatusBarStyle: UIStatusBarStyle { current.preferredStatusBarStyle }
    #endif
    public internal(set) var current: UIViewController = NotImplementedViewController("nothing")
    
    @UState public internal(set) var currentType: RootScreenType = .nothing
    
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
    
    open var shouldShowOnboardingBeforeMainScreen: Bool { true }
    
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
    
    @discardableResult
    @available(*, deprecated, message: "Please use `switch(to:)`")
    open func showOnboardingScreen() -> Bool {
        guard onboardingScreen != nil else { return false }
        `switch`(to: .onboarding, animation: .none)
        return true
    }
    
    @available(*, deprecated, message: "Please use `switch(to:)`")
    open func showLoginScreen() {
        `switch`(to: .login, animation: .none)
    }
    
    @available(*, deprecated, message: "Please use `switch(to:)`")
    open func switchToLogout(beforeTransition: RootBeforeTransition? = nil, completion: RootSimpleCompletion? = nil) {
        `switch`(to: .logout, animation: .dismiss, beforeTransition: beforeTransition, completion: completion)
    }
    
    @available(*, deprecated, message: "Please use `switch(to:)`")
    open func switchToMainScreen(beforeTransition: RootBeforeTransition? = nil, completion: RootSimpleCompletion? = nil) {
        `switch`(to: .main, animation: .fade, beforeTransition: beforeTransition, completion: completion)
    }
    
    open func `switch`(to type: RootScreenType, animation: RootTransitionAnimation, beforeTransition: RootBeforeTransition?, completion: RootSimpleCompletion?) {
        if currentType == type {
            print("⚠️ Don't show \(type) twice")
            return
        }
        guard let vc = nextViewController(for: type) else { return }
        if shouldShowOnboardingBeforeMainScreen, onboardingScreen != nil {
            `switch`(to: .onboarding, animation: animation, beforeTransition: beforeTransition, completion: completion)
            return
        }
        currentType = type
        beforeTransition?(vc)
        switch animation {
        case .none:
            replaceWithoutAnimation(loginScreen)
            proceedDeeplink()
            completion?()
        case .dismiss:
            animateDismissTransition(to: vc) { [weak self] in
                if type == .logout {
                    self?.currentType = .login
                }
                self?.proceedDeeplink()
                completion?()
            }
        case .fade:
            animateFadeTransition(to: vc) { [weak self] in
                if type == .logout {
                    self?.currentType = .login
                }
                self?.proceedDeeplink()
                completion?()
            }
        }
    }
    
    public func `switch`(to: UIViewController, as: RootScreenType, animation: RootTransitionAnimation, beforeTransition: RootBeforeTransition? = nil, completion: RootSimpleCompletion? = nil) {
        currentType = `as`
        switch animation {
        case .none:
            beforeTransition?(to)
            replaceWithoutAnimation(to)
            proceedDeeplink()
            completion?()
        case .dismiss:
            beforeTransition?(to)
            animateDismissTransition(to: to) {
                self.proceedDeeplink()
                completion?()
            }
        case .fade:
            beforeTransition?(to)
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
        #if !os(tvOS)
        setNeedsStatusBarAppearanceUpdate()
        #endif
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: RootSimpleCompletion? = nil) {
        current.willMove(toParent: nil)
        new.view.frame = self.view.bounds
        addChild(new)
        new.willMove(toParent: self)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {}) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
            #if !os(tvOS)
            self.setNeedsStatusBarAppearanceUpdate()
            #endif
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
            #if !os(tvOS)
            self.setNeedsStatusBarAppearanceUpdate()
            #endif
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

extension UIViewController {
    @available(macCatalystApplicationExtension, unavailable)
    @available(OSXApplicationExtension, unavailable)
    @available(iOSApplicationExtension, unavailable)
    public var rootController: RootControllerable {
        view.rootController
    }
}

extension UIView {
    @available(macCatalystApplicationExtension, unavailable)
    @available(OSXApplicationExtension, unavailable)
    @available(iOSApplicationExtension, unavailable)
    public var rootController: RootControllerable {
        if #available(iOS 13.0, *) {
            guard
                let scene = UIApplication.shared.connectedScenes.first(where: {
                    ($0.delegate as? UIWindowSceneDelegate)?.window == self.window
                }),
                let delegate = scene.delegate as? UIWindowSceneDelegate,
                let window = delegate.window,
                let rootController = window?.rootViewController as? RootControllerable
            else {
                return appDelegateRootController
            }
            return rootController
//            (!.delegate as! UIWindowSceneDelegate).window!!.rootViewController as! RootViewController
//            UIApplication.shared.connectedScenes.first?.activationState = UIScene.ActivationState.foregroundActive
//            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
//            return window!.rootViewController as! RootViewController
        } else {
            return appDelegateRootController
        }
    }
    
//    @available(macCatalyst, introduced: 1.0, deprecated: 2.0, obsoleted: 9.0,
//    @available(macOS 10.12, iOS 9.3, tvOS 9.2, watchOS 3.0, *)
    @available(macCatalystApplicationExtension, unavailable)
    @available(OSXApplicationExtension, unavailable)
    @available(iOSApplicationExtension, unavailable)
    private var appDelegateRootController: RootControllerable {
        guard
            let delegate = UIApplication.shared.delegate
        else {
            #if DEBUG
            fatalError("Unable to reach UIApplicationDelegate")
            #else
            return SimpleRootController()
            #endif
        }
        return delegate.rootController
    }
}

extension UIApplicationDelegate {
    @available(macCatalystApplicationExtension, unavailable)
    @available(OSXApplicationExtension, unavailable)
    @available(iOSApplicationExtension, unavailable)
    public var rootController: RootControllerable {
        guard
            let rootController = window??.rootViewController as? RootControllerable
        else {
            #if DEBUG
            fatalError("Unable to reach RootViewController")
            #else
            return SimpleRootController()
            #endif
        }
        return rootController
    }
}
