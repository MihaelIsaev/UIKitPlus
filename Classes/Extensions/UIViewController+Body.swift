import UIKit

extension UIViewController {
    open func body(@ViewBuilder block: ViewBuilder.SingleView) {
        view.body { block().viewBuilderItems }
    }
}
