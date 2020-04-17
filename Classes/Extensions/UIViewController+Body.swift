import UIKit

extension UIViewController {
    open func body(@ViewBuilder block: ViewBuilder.SingleView) {
        if let s = self as? ViewController {
            s._view.body { block().viewBuilderItems }
        } else {
            view.body { block().viewBuilderItems }
        }
    }
}
