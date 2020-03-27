🍀Useful root navigation view controller (by best practice)

## How to use

Create a `RootViewController.swift` in your project and inherit it from `RootController<DeeplinkType>` like this

```swift
import UIKitPlus

class RootViewController: SwifRootViewController<DeeplinkType> {
    // may be shown on app launch as initial view controller
    override var splashScreen: UIViewController {
        SplashViewController() // replace with yours
    }

    // where user will be moved on `showLoginScreen`
    override var loginScreen: UIViewController {
        LoginViewController() // replace with yours
    }

    // where user will be moved on `switchToLogout`
    override var logoutScreen: UIViewController {
        LoginViewController() // replace with yours
    }

    // means your main view controller for authorized users
    override var mainScreen: UIViewController {
        MainViewController() // replace with yours
    }

    // shows before main screen
    override var onboardingScreen: UIViewController? {
        // return something here to show it right after authorization
        nil
    }

    // check authorization here and return proper screen
    override var initialScreen: UIViewController {
        Session.shared.isAuthorized ? splashScreen : loginScreen
    }

    // handle deep links here
    override func handleDeepLink(type: DeeplinkType) {
        /// check you deep link in switch/case
        /// and go to the proper view controller
    }
}
```

> 💡 If you don't want to use deep links for now you could use `SimpleRootController` instead of `RootController<DeeplinkType>`

##### Setting `RootViewController` as a window's `rootViewController`

```swift
@UIApplicationMain
class AppDelegateBase: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if super.application(application, didFinishLaunchingWithOptions: launchOptions) {
        window = UIWindow(frame: UIScreen.main.bounds)
        // needed to set `RootViewController` as window's `rootViewController`
        RootViewController().attach(to: window)
        // needed for deep links registration
        // ShortcutParser.shared.registerShortcuts()
        return true
    }
    return false
  }
}
```

### Switching screens
First of all declare helpers in `AppDelegate`
```swift
extension AppDelegate {
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    var rootViewController: RootViewController {
        window!.rootViewController as! RootViewController
    }
}
```
Then use them from anywhere like this
```swift
AppDelegate.shared.rootViewController.showLoginScreen()
AppDelegate.shared.rootViewController.switchToMainScreen()
AppDelegate.shared.rootViewController.switchToLogout()
```

### Deep links

##### Setting `RootViewController` as a window's `rootViewController`

Implement `ShortcutParser`
```swift
import Foundation
import UIKit

enum ShortcutKey: String {
    case activity = "com.yourapp.activity"
    case messages = "com.yourapp.messages"
}

class ShortcutParser {
    static let shared = ShortcutParser()
    private init() { }

    func registerShortcuts() {
        let activityIcon = UIApplicationShortcutIcon(type: .invitation)
        let activityShortcutItem = UIApplicationShortcutItem(type: ShortcutKey.activity.rawValue, localizedTitle: "Recent Activity", localizedSubtitle: nil, icon: activityIcon, userInfo: nil)

        let messageIcon = UIApplicationShortcutIcon(type: .message)
        let messageShortcutItem = UIApplicationShortcutItem(type: ShortcutKey.messages.rawValue, localizedTitle: "Messages", localizedSubtitle: nil, icon: messageIcon, userInfo: nil)

        UIApplication.shared.shortcutItems = [activityShortcutItem, messageShortcutItem]
    }

    func handleShortcut(_ shortcut: UIApplicationShortcutItem) -> DeeplinkType? {
        switch shortcut.type {
        case ShortcutKey.activity.rawValue:
            return  .activity
        case ShortcutKey.messages.rawValue:
            return  .messages
        default:
            return nil
        }
    }
}
```

Implement `DeepLinkManager`
```swift
import UIKitPlus

// List your deeplinks in this enum
enum DeeplinkType {
    case messages
    case activity
}

let Deeplinker = DeepLinkManager()
class DeepLinkManager {
    fileprivate init() {}

    private var deeplinkType: DeeplinkType?

    @discardableResult
    func handleShortcut(item: UIApplicationShortcutItem) -> Bool {
        deeplinkType = ShortcutParser.shared.handleShortcut(item)
        return deeplinkType != nil
    }

    // check existing deepling and perform action
    func checkDeepLink() {
        if let rootViewController = AppDelegate.shared.rootViewController as? RootViewController {
            rootViewController.deeplink = deeplinkType
        }

        // reset deeplink after handling
        self.deeplinkType = nil
    }
}

```

Configure `AppDelegate`
```swift
@UIApplicationMain
class AppDelegateBase: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if super.application(application, didFinishLaunchingWithOptions: launchOptions) {
        // needed to set `RootViewController` aswindow's  `rootViewController`
        RootViewController().attach(to: &window)
        // needed for deep links registration
        ShortcutParser.shared.registerShortcuts()
        return true
    }
    return false
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    Deeplinker.checkDeepLink()
  }

  // MARK: Shortcuts

  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    completionHandler(Deeplinker.handleShortcut(item: shortcutItem))
  }
}
```
