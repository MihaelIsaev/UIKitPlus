import UIKit

class CollectionDynamicCell: CollectionViewCell {
    func setRootView(_ rootView: VStack) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.body { rootView.edgesToSuperview() }
    }
}
