import UIKit

public enum ViewBuilderItem {
    case none
    case single(UIView)
    case multiple([UIView])
    case nested([ViewBuilderItemable])
    case forEach(AnyForEach)
}
public protocol ViewBuilderItemable {
    var viewBuilderItem: ViewBuilderItem { get }
}
public struct EmptyViewBuilderItem: ViewBuilderItemable {
    public var viewBuilderItem: ViewBuilderItem { .none }
}
extension UIView: ViewBuilderItemable {
    public var viewBuilderItem: ViewBuilderItem { .single(self) }
}
extension Array: ViewBuilderItemable where Element: UIView {
    public var viewBuilderItem: ViewBuilderItem { .multiple(self) }
}
extension Optional: ViewBuilderItemable where Wrapped: UIView {
    public var viewBuilderItem: ViewBuilderItem {
        switch self {
        case .none: return .none
        case .some(let value): return .single(value)
        }
    }
}
