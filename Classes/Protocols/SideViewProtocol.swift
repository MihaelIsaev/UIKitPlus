#if os(macOS)
import AppKit
#else
import UIKit
#endif

protocol SideViewProtocol {
    var view: BaseView { get }
}
