import UIKit

extension UIViewController {
    open func body(@ViewBuilder block: ViewBuilder.SingleView) {
        self.view.addSubview(block().viewBuilderItems)
    }
}
