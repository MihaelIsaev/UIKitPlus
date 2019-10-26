import UIKit

extension UIView {
    public func addSubview(_ views: [UIView]) {
        body { views }
    }
    
    public func addSubview(_ views: UIView...) {
        body { views }
    }
    
    public func addSubview<V>(_ view: ()->(V)) where V: DeclarativeProtocol {
        body { view().declarativeView }
    }
}
