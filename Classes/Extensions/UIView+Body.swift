import UIKit

extension UIView {
    @discardableResult
    open func body(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        addSubview(block().viewBuilderItems)
        return self
    }
}
