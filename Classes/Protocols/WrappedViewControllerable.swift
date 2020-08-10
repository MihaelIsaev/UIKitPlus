#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol WrappedViewControllerable {
    var protocolView: View { get }
    var protocolController: BaseViewController { get }
}
