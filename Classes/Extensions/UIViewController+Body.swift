#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension BaseViewController {
    open func body(@ViewBuilder block: ViewBuilder.SingleView) {
        view.body { block() }
    }
}
