//
//  MacOSApplication.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 13.08.2020.
//

#if os(macOS)
import Cocoa

@NSApplicationMain
open class App: NSApplication, NSApplicationDelegate {
    public static override var shared: App { super.shared as! App }
    
    static var currentTheme: Theme {
        UserDefaults.standard.string(forKey: "AppleInterfaceStyle")?.lowercased() == "dark" ? .dark : .light
    }
    
    @State public var theme: Theme = App.currentTheme
    
    public override init() {
        super.init()
        delegate = self
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func applicationDidFinishLaunching(_ aNotification: Notification) {
        parseAppBuilderItem(body.appBuilderContent)
        DistributedNotificationCenter.default.addObserver(
            self,
            selector: #selector(interfaceModeChanged),
            name: Notification.Name("AppleInterfaceThemeChangedNotification"),
            object: nil
        )
    }
    
    @objc private func interfaceModeChanged() {
        self.theme = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")?.lowercased() == "dark" ? .dark : .light
    }
    
    public enum Theme: CustomStringConvertible {
        case light, dark
        
        public var description: String {
            self == .light ? "light" : "dark"
        }
    }

    private var _windows: [Window] = []
    private var _statusItems: [StatusItem] = []

    @AppBuilder open var body: AppBuilderContent { Window() }

    private func parseAppBuilderItem(_ item: AppBuilderItem) {
        switch item {
        case .statusItems(let values): _statusItems.append(contentsOf: values)
        case .windows(let values): _windows.append(contentsOf: values)
        case .items(let items): items.forEach { parseAppBuilderItem($0) }
        case .none: break
        }
    }
}


//public protocol WindowsBuilderContent {
//    var windowsBuilderContent: WindowsBuilderItem { get }
//}
//
//public enum WindowsBuilderItem {
//    case none
//    case windows([Window])
//    case items([WindowsBuilderItem])
//}
//
//struct _Content: WindowsBuilderContent {
//    let windowsBuilderContent: WindowsBuilderItem
//}
//
//@_functionBuilder public struct WindowsBuilder {
//    public typealias Block = () -> WindowsBuilderContent
//    
//    public static func buildBlock() -> WindowsBuilderContent {
//        _Content(windowsBuilderContent: .none)
//    }
//    
//    public static func buildBlock(_ attrs: WindowsBuilderContent...) -> WindowsBuilderContent {
//        buildBlock(attrs)
//    }
//    
//    public static func buildBlock(_ attrs: [WindowsBuilderContent]) -> WindowsBuilderContent {
//        _Content(windowsBuilderContent: .items(attrs.map { $0.windowsBuilderContent }))
//    }
//    
//    public static func buildIf(_ content: WindowsBuilderContent?) -> WindowsBuilderContent {
//        guard let content = content else { return _Content(windowsBuilderContent: .none) }
//        return _Content(windowsBuilderContent: .items([content.windowsBuilderContent]))
//    }
//    
//    public static func buildEither(first: WindowsBuilderContent) -> WindowsBuilderContent {
//        _Content(windowsBuilderContent: .items([first.windowsBuilderContent]))
//    }
//
//    public static func buildEither(second: WindowsBuilderContent) -> WindowsBuilderContent {
//        _Content(windowsBuilderContent: .items([second.windowsBuilderContent]))
//    }
//}

public protocol AppBuilderContent {
    var appBuilderContent: AppBuilderItem { get }
}

public enum AppBuilderItem {
    case none
    case statusItems([StatusItem])
    case windows([Window])
    case items([AppBuilderItem])
}

struct _AppContent: AppBuilderContent {
    let appBuilderContent: AppBuilderItem
}

@_functionBuilder public struct AppBuilder {
    public typealias Block = () -> AppBuilderContent
    
    public static func buildBlock() -> AppBuilderContent {
        _AppContent(appBuilderContent: .none)
    }
    
    public static func buildBlock(_ attrs: AppBuilderContent...) -> AppBuilderContent {
        buildBlock(attrs)
    }
    
    public static func buildBlock(_ attrs: [AppBuilderContent]) -> AppBuilderContent {
        _AppContent(appBuilderContent: .items(attrs.map { $0.appBuilderContent }))
    }
    
    public static func buildIf(_ content: AppBuilderContent?) -> AppBuilderContent {
        guard let content = content else { return _AppContent(appBuilderContent: .none) }
        return _AppContent(appBuilderContent: .items([content.appBuilderContent]))
    }
    
    public static func buildEither(first: AppBuilderContent) -> AppBuilderContent {
        _AppContent(appBuilderContent: .items([first.appBuilderContent]))
    }

    public static func buildEither(second: AppBuilderContent) -> AppBuilderContent {
        _AppContent(appBuilderContent: .items([second.appBuilderContent]))
    }
}

#else

#endif
