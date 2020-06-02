import UIKit

class ListDynamicCell: TableViewCell {
    func setRootViews(_ views: UIView...) {
        setRootViews(views)
    }
    
    func setRootViews(_ views: [UIView]) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.body { views }
    }
}
