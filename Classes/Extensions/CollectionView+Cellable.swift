import Foundation
import UIKit

extension UICollectionView {
    public func register(_ cellClass: Cellable.Type...) {
        cellClass.forEach { register($0, forCellWithReuseIdentifier: $0.reuseIdentifier) }
    }
    
    public func dequeueReusableCell<T: Cellable>(with class: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: `class`.reuseIdentifier, for: indexPath) as! T
    }
}
