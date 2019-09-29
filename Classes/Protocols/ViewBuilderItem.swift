import UIKit

public protocol ViewBuilderItem {
    var viewBuilderItems: [UIView] { get }
}
extension UIView: ViewBuilderItem {
    public var viewBuilderItems: [UIView] {
        return [self]
    }
}
extension Array: ViewBuilderItem where Element: UIView {
    public var viewBuilderItems: [UIView] {
        return self
    }
}
extension Optional: ViewBuilderItem where Wrapped: UIView {
    public var viewBuilderItems: [UIView] {
        switch self {
        case .none: return []
        case .some(let value): return [value]
        }
    }
}
