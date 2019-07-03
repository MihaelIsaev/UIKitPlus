import UIKit

extension UIView {
    public func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    public func addSubview(_ view: ()->(View)) {
        addSubview(view())
    }
}
