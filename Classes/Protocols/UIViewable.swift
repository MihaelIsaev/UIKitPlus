import UIKit

public protocol UIViewable: DeclarativeProtocol {
    var _view: UIView { get }
}

extension UIViewable {
    public var _view: UIView { declarativeView }
}
