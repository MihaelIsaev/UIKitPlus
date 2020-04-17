//___FILEHEADER___

import UIKitPlus

class RootViewController: RootController<DeeplinkType> {
    /// this is UIKitPlus universal `statusBarStyle`
    /// which works with any iOS version
    /// and can be set at any view controller
//    override var statusBarStyle: StatusBarStyle { .default }

    /// calls first
    /// here you should decide which view controller is initial
    override var initialScreen: UIViewController {
        loginScreen
        /// if your app has an authentication
        /// then you may want to show the splash screen if user is authorized
        /// otherwise show the login screen
//        Session.isAuthorized ? splashScreen : loginScreen
    }

    /// splash screen which usually should switch to the main screen automatically
    /// comment it out or remove if you have no splash screen in your app
    override var splashScreen: UIViewController { SplashViewController() }

    /// if your app have login screen then point this property
    /// to the right view controller
    /// otherwise you can comment out or remove this declaration
    override var loginScreen: UIViewController {
        NavigationController(WelcomeViewController()).style(.transparent).hideNavigationBar()
    }

    /// usually it is the same as login screen
    /// if it is the same in your app then leave it as it is
    /// otherwise point to your custom logout view controller
    override var logoutScreen: UIViewController { loginScreen }

    /// the main screen of the app which usually shows after splash screen
    override var mainScreen: UIViewController {
        NavigationController(MainViewController()).style(.transparent).hideNavigationBar()
    }

    /// absolutely optional screen which will be shown before main screen if it's not nil
    override var onboardingScreen: UIViewController? { nil }

    // MARK: Deep Links

    override func handleDeepLink(type: DeeplinkType) {}

    // MARK: Custom Methods
    
    func switchToSplash() {
        `switch`(to: splashScreen, as: .splash, animation: .fade)
    }
}

#if canImport(SwiftUI) && DEBUG
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
