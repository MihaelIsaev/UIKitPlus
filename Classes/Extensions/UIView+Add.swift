import UIKit

extension UIView {
    public func addSubview(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    public func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    public func addSubview<V>(_ view: ()->(V)) where V: DeclarativeProtocol {
        addSubview(view().declarativeView)
    }
}
