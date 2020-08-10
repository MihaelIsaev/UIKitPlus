#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol UIViewable: DeclarativeProtocol {
    var _view: BaseView { get }
}

extension UIViewable {
    public var _view: BaseView { declarativeView }
}
