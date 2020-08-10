#if !os(macOS)
import UIKit

open class ActionSheet: UIAlertController, _Titleable, _Messageable, _UIAlertViewControllerable {
    public convenience init() {
        self.init(title: nil, message: nil, preferredStyle: .actionSheet)
    }

    func _setTitle(_ v: String?) {
        title = v
    }

    func _setMessage(_ v: String?) {
        message = v
    }

    func _present(in vc: UIViewController, animated: Bool, completion: (() -> Void)?) -> Self {
        vc.present(self, animated: true, completion: completion)
        return self
    }
}

open class AlertController: UIAlertController, _Titleable, _Messageable, _UIAlertViewControllerable {
    public convenience init(_ style: UIAlertController.Style) {
        self.init(title: nil, message: nil, preferredStyle: style)
    }
    
    func _setTitle(_ v: String?) {
        title = v
    }
    
    func _setMessage(_ v: String?) {
        message = v
    }
    
    func _present(in vc: UIViewController, animated: Bool, completion: (() -> Void)?) -> Self {
        vc.present(self, animated: true, completion: completion)
        return self
    }
    
    @discardableResult
    public func sourceView(_ view: UIView) -> Self {
        popoverPresentationController?.sourceView = view
        return self
    }
}

open class AlertAction: UIAlertAction, _Enableable {
    func _setEnabled(_ v: Bool) {
        isEnabled = v
    }
}

public protocol UIAlertViewControllerable {
    @discardableResult
    func action(_ title: String?, _ style: UIAlertAction.Style, _ handler: @escaping ((AlertAction) -> Void)) -> Self
    
    @discardableResult
    func action(_ title: String?, _ handler: @escaping ((AlertAction) -> Void)) -> Self
    
    @discardableResult
    func action(_ title: String?) -> Self
    
    @discardableResult
    func action(_ title: String?, _ style: UIAlertAction.Style, _ handler: @escaping (() -> Void)) -> Self
    
    @discardableResult
    func action(_ title: String?, _ handler: @escaping (() -> Void)) -> Self
    
    @discardableResult
    func destructive(_ title: String?, _ handler: @escaping ((AlertAction) -> Void)) -> Self
    
    @discardableResult
    func destructive(_ title: String?, _ handler: @escaping (() -> Void)) -> Self
    
    @discardableResult
    func destructive(_ title: String?) -> Self
    
    @discardableResult
    func cancel(_ title: String?, _ handler: @escaping ((AlertAction) -> Void)) -> Self
    
    @discardableResult
    func cancel(_ title: String?, _ handler: @escaping (() -> Void)) -> Self
    
    @discardableResult
    func cancel(_ title: String?) -> Self
    
    @discardableResult
    func present(in vc: UIViewController, animated: Bool, completion: @escaping (() -> Void)) -> Self
    
    @discardableResult
    func present(in vc: UIViewController, animated: Bool) -> Self
    
    @discardableResult
    func present(in vc: UIViewController, completion: @escaping (() -> Void)) -> Self
    
    @discardableResult
    func present(in vc: UIViewController) -> Self
    
    func addAction(_ action: UIAlertAction)
}

protocol _UIAlertViewControllerable: UIAlertViewControllerable {
    func _present(in vc: UIViewController, animated: Bool, completion: (() -> Void)?) -> Self
}

extension UIAlertViewControllerable {
    @discardableResult
    public func action(_ title: String?, _ style: UIAlertAction.Style, _ handler: @escaping ((AlertAction) -> Void)) -> Self {
       addAction(AlertAction(title: title, style: style) {
           handler($0 as! AlertAction)
       })
       return self
    }
    
    @discardableResult
    public func action(_ title: String?, _ handler: @escaping ((AlertAction) -> Void)) -> Self {
        action(title, .default, handler)
    }
    
    @discardableResult
    public func action(_ title: String?) -> Self {
        action(title, .default) {}
    }
    
    @discardableResult
    public func action(_ title: String?, _ style: UIAlertAction.Style, _ handler: @escaping (() -> Void)) -> Self {
        action(title, style) { _ in handler() }
    }
    
    @discardableResult
    public func action(_ title: String?, _ handler: @escaping (() -> Void)) -> Self {
        action(title, .default, handler)
    }
    
    @discardableResult
    public func destructive(_ title: String?, _ handler: @escaping ((AlertAction) -> Void)) -> Self {
        action(title, .destructive, handler)
    }
    
    @discardableResult
    public func destructive(_ title: String?, _ handler: @escaping (() -> Void)) -> Self {
        action(title, .destructive, handler)
    }
    
    @discardableResult
    public func destructive(_ title: String?) -> Self {
        destructive(title) { _ in }
    }
    
    @discardableResult
    public func cancel(_ title: String?, _ handler: @escaping ((AlertAction) -> Void)) -> Self {
        action(title, .cancel, handler)
    }
    
    @discardableResult
    public func cancel(_ title: String?, _ handler: @escaping (() -> Void)) -> Self {
        action(title, handler)
    }
    
    @discardableResult
    public func cancel(_ title: String?) -> Self {
        action(title, .cancel) {}
    }
    
    @discardableResult
    public func present(in vc: UIViewController, animated: Bool, completion: @escaping (() -> Void)) -> Self {
        guard let s = self as? _UIAlertViewControllerable else { return self }
        return s._present(in: vc, animated: animated, completion: completion) as! Self
    }
    
    @discardableResult
    public func present(in vc: UIViewController, animated: Bool) -> Self {
        present(in: vc, animated: animated) {}
    }
    
    @discardableResult
    public func present(in vc: UIViewController, completion: @escaping (() -> Void)) -> Self {
        present(in: vc, animated: true, completion: completion)
    }
    
    @discardableResult
    public func present(in vc: UIViewController) -> Self {
        present(in: vc) {}
    }
}
#endif
