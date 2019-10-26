import UIKit

extension UIImage: SegmentControlable {
    public var item: SegmentControlableItem { .image(self) }
}
