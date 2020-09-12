#if !os(macOS)
import UIKit

public protocol AnyRootController {
    init ()
    
    /// Needed to attach to classic window
    func attach(to window: UIWindow?)
    
    /// Needed to attach to scene's window
    @available(iOS 13.0, *)
    @discardableResult
    func attach(to scene: UIScene) -> UIWindow?
}

public protocol RootControllerable: AnyRootController {
    var current: UIViewController {  get }
    
    var currentType: RootScreenType { get }
    
    var shouldShowOnboardingBeforeMainScreen: Bool { get }
    
    var initialScreen: UIViewController { get }
    
    var splashScreen: UIViewController { get }
    var loginScreen: UIViewController { get }
    var logoutScreen: UIViewController { get }
    var mainScreen: UIViewController { get }
    var onboardingScreen: UIViewController? { get }
    
    func `switch`(to: RootScreenType)
    
    func `switch`(to: RootScreenType, animation: RootTransitionAnimation)
    func `switch`(to: RootScreenType, animation: RootTransitionAnimation, beforeTransition: @escaping RootBeforeTransition)
    func `switch`(to: RootScreenType, animation: RootTransitionAnimation, completion: @escaping RootSimpleCompletion)
    
    func `switch`(to: RootScreenType, beforeTransition: @escaping RootBeforeTransition)
    func `switch`(to: RootScreenType, beforeTransition: @escaping RootBeforeTransition, completion: @escaping RootSimpleCompletion)
    
    func `switch`(to: RootScreenType, completion: @escaping RootSimpleCompletion)
    
    func `switch`(to type: RootScreenType, animation: RootTransitionAnimation, beforeTransition: RootBeforeTransition?, completion: RootSimpleCompletion?)
    
    func `switch`(to: UIViewController, as: RootScreenType, animation: RootTransitionAnimation, beforeTransition: RootBeforeTransition?, completion: RootSimpleCompletion?)
}

extension RootControllerable {
    public func `switch`(to: RootScreenType) {
        `switch`(to: to, animation: .fade, beforeTransition: nil, completion: nil)
    }
    
    public func `switch`(to: RootScreenType, animation: RootTransitionAnimation) {
        `switch`(to: to, animation: animation, beforeTransition: nil, completion: nil)
    }
    
    public func `switch`(to: RootScreenType, animation: RootTransitionAnimation, beforeTransition: @escaping RootBeforeTransition) {
        `switch`(to: to, animation: animation, beforeTransition: beforeTransition, completion: nil)
    }
    
    public func `switch`(to: RootScreenType, animation: RootTransitionAnimation, completion: @escaping RootSimpleCompletion) {
        `switch`(to: to, animation: animation, beforeTransition: nil, completion: completion)
    }
    
    public func `switch`(to: RootScreenType, beforeTransition: @escaping RootBeforeTransition) {
        `switch`(to: to, animation: .fade, beforeTransition: beforeTransition, completion: nil)
    }
    
    public func `switch`(to: RootScreenType, beforeTransition: @escaping RootBeforeTransition, completion: @escaping RootSimpleCompletion) {
        `switch`(to: to, animation: .fade, beforeTransition: beforeTransition, completion: completion)
    }
    
    public func `switch`(to: RootScreenType, completion: @escaping RootSimpleCompletion) {
        `switch`(to: to, animation: .fade, beforeTransition: nil, completion: completion)
    }
    
    public func `switch`(to type: RootScreenType, animation: RootTransitionAnimation, beforeTransition: RootBeforeTransition?, completion: RootSimpleCompletion?) {
        guard let vc = nextViewController(for: type) else { return }
        `switch`(to: vc, as: type, animation: animation, beforeTransition: beforeTransition, completion: completion)
    }
    
    func nextViewController(for type: RootScreenType) -> UIViewController? {
        switch type {
        case .splash: return splashScreen
        case .login: return loginScreen
        case .logout: return logoutScreen
        case .main: return mainScreen
        case .onboarding: return onboardingScreen ?? mainScreen
        default: return nil
        }
    }
}
#endif
