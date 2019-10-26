import UIKit

extension UIView {
    public func addSubview(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    public func addSubview(_ views: UIView...) {
        addSubview(views)
    }
    
    public func addSubview<V>(_ view: ()->(V)) where V: DeclarativeProtocol {
        body { view().declarativeView }
    }
}
