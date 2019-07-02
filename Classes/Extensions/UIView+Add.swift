import UIKit

extension UIView {
    public func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
