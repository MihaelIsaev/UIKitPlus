import UIKit

class ListDynamicCell: TableViewCell {
    func setRootView(_ rootView: VStack) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.addSubview(rootView.edgesToSuperview())
    }
}
