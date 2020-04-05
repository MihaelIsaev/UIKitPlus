//___FILEHEADER___

import UIKitPlus

class RootViewController: RootController<DeeplinkType> {
//    override var statusBarStyle: StatusBarStyle { .default }
    
    //SimpleRootController {
    override var initialScreen: UIViewController {
            loginScreen
    //        Session.isAuthorized ? splashScreen : loginScreen
        }
    override var splashScreen: UIViewController { SplashViewController() }
    override var loginScreen: UIViewController {
        NavigationController(WelcomeViewController()).style(.transparent).hideNavigationBar()
    }
    override var logoutScreen: UIViewController { loginScreen }
    override var mainScreen: UIViewController {
        NavigationController(MainViewController()).style(.transparent).hideNavigationBar()
    }
    override var onboardingScreen: UIViewController? { nil }
    override func handleDeepLink(type: DeeplinkType) {}
    func switchToSplash() {
        `switch`(to: splashScreen, as: .splash, animation: .fade)
    }
}

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)
struct RootViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            RootViewController()
        }
        .colorScheme(.light)
        .device(.iPhoneX)
    }
}
#endif
