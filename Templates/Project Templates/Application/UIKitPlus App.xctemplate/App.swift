//___FILEHEADER___

import UIKitPlus

class App: BaseApp {
    @AppBuilder override var body: AppBuilderContent {
        Lifecycle.didFinishLaunching {
            self.$pushNotificationToken.listen { token in
                // handle your push token here
                print("push token: \(token ?? "n/a")")
            }
            // request push token authorization like this
            App.requestPushNotificationsAuthorization(.alert, .sound, .badge)
        }.willResignActive {
            
        }.willEnterForeground {
            
        }
        MainScene {
//            Session.isAuthorized ? .splash : .login
            .splash
        }.splashScreen {
            SplashViewController()
        }.loginScreen {
            NavigationController(WelcomeViewController()).style(.transparent).hideNavigationBar()
        }.mainScreen {
            NavigationController(MainViewController()).style(.transparent).hideNavigationBar()
        }
//        Shortcuts {
//            Shortcut("A").title("Test 1").icon(type: .audio)
//            Shortcut("B").title("Test 2").subTitle("Hello world").icon(type: .bookmark)
//        }
    }
}
