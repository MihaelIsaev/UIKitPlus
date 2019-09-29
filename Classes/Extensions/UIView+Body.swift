import UIKit

extension UIView {
    open func body(@ViewBuilder block: ViewBuilder.SingleView) {
        addSubview(block().viewBuilderItems)
    }
}
