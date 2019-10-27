import UIKit

public protocol RootControllerable {
    var splashScreen: UIViewController { get }
    var loginScreen: UIViewController { get }
    var logoutScreen: UIViewController { get }
    var mainScreen: UIViewController { get }
    var onboardingScreen: UIViewController? { get }

    func showLoginScreen()
    func showOnboardingScreen() -> Bool
    func switchToLogout(beforeTransition: RootBeforeTransition?, completion: RootSimpleCompletion?)
    func switchToMainScreen(beforeTransition: RootBeforeTransition?, completion: RootSimpleCompletion?)
    func `switch`(to: UIViewController, as: RootScreenType, animation: RootTransitionAnimation, completion: RootSimpleCompletion?)
}
