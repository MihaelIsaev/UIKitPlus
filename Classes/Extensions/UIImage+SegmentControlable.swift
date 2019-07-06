import UIKit

extension UIImage: SegmentControlable {
    public var item: SegmentControlableItem { return .image(self) }
}
