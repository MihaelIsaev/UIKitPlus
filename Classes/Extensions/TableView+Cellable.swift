import Foundation
import UIKit

extension UITableView {
    public func register(_ cellClass: Cellable.Type...) {
        cellClass.forEach { register($0, forCellReuseIdentifier: $0.reuseIdentifier) }
    }
    
    public func dequeueReusableCell<T: Cellable>(with class: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: `class`.reuseIdentifier, for: indexPath) as! T
    }
}
