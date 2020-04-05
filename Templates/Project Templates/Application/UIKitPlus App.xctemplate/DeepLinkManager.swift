//___FILEHEADER___

import UIKitPlus

enum DeeplinkType {
    case application
}

let Deeplinker = DeepLinkManager()
class DeepLinkManager {
    fileprivate init() {}
    
    private var deeplinkType: DeeplinkType?
    
    @discardableResult
    func handleShortcut(item: UIApplicationShortcutItem) -> Bool {
        //deeplinkType = ShortcutParser.shared.handleShortcut(item)
        return false//deeplinkType != nil
    }
    
    // check existing deepling and perform action
    func checkDeepLink() {
        //        if let rootViewController = AppDelegate.shared.rootViewController as? RootViewController {
        //            rootViewController.deeplink = deeplinkType
        //        }
        
        // reset deeplink after handling
        self.deeplinkType = nil
    }
}
