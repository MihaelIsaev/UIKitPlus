import Foundation
import UIKit

open class NavigationController<T: UIViewController>: UINavigationController, UIGestureRecognizerDelegate {
    private lazy var font: UIFont = .systemFont(ofSize: 17)
    private lazy var style: NavigationControllerStyle = .default
    private lazy var statusBarStyle: UIStatusBarStyle = .default
    private lazy var tintColor: UIColor = .white
    
    private var viewController: T? { return viewControllers.first as? T }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let vc = viewControllers.last {
//            if let vc = vc as? NavControllerStyleable {
//                return vc.navStatusBarStyle
//            } else {
                return vc.preferredStatusBarStyle
//            }
        }
        return statusBarStyle
    }
    
    public init() {
        let viewController = T(nibName: nil, bundle: nil)
        super.init(rootViewController: viewController)
        setup()
    }
    
    public init(_ rootViewController: T) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    public init(_ type: T.Type) {
        let viewController = type.init(nibName: nil, bundle: nil)
        super.init(rootViewController: viewController)
        setup()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
        //        automaticallyAdjustsScrollViewInsets = true // TODO: either delete or fix
        //        extendedLayoutIncludesOpaqueBars = true
        navigationBar.titleTextAttributes = [.foregroundColor: tintColor, .font: font]
        navigationBar.tintColor = tintColor
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.setBackgroundImage(UIImage(), for: .compact)
        navigationBar.shadowImage = UIImage()
        switch style {
        case .default:
//            navigationBar.barTintColor = customTintColor
            navigationBar.isTranslucent = false
        case .transparent:
            navigationBar.backgroundColor = UIColor.clear
            navigationBar.isTranslucent = true
        case .color(let color):
            navigationBar.barTintColor = color
            navigationBar.backgroundColor = color
            navigationBar.isTranslucent = true
        }
    }
    
    // MARK: UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    // MARK: Style
    
    @discardableResult
    public func style(_ style: NavigationControllerStyle = .default) -> NavigationController {
//        guard let vc = viewController as? NavControllerStyleable else {
            self.style = style
            setupAppearance()
            return self
//        }
//        self.style = vc.navStyle
////        if let color = vc.navTintColor {
////            tintColor = color
////        }
//        statusBarStyle = vc.navStatusBarStyle
//        setupAppearance()
//        return self
    }
    
    // MARK: Font
    
    @discardableResult
    public func font(v: UIFont?) -> NavigationController {
        if let font = v {
            self.font = font
            setupAppearance()
        }
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> NavigationController {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func statusBarStyle(_ style: UIStatusBarStyle) -> NavigationController {
        statusBarStyle = style
        setNeedsStatusBarAppearanceUpdate()
        return self
    }
    
    //    public func setupModal() {
    //        modalTransitionStyle = .coverVertical
    //        modalPresentationStyle = .fullScreen
    //    }
}

