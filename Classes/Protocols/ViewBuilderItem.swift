#if os(macOS)
import AppKit
#else
import UIKit
#endif

public enum ViewBuilderItem {
    case none
    case single(BaseView)
    case multiple([BaseView])
    case nested([ViewBuilderItemable])
    case forEach(AnyForEach)
}
public protocol ViewBuilderItemable {
    var viewBuilderItem: ViewBuilderItem { get }
}
public struct EmptyViewBuilderItem: ViewBuilderItemable {
    public var viewBuilderItem: ViewBuilderItem { .none }
}
extension BaseView: ViewBuilderItemable {
    public var viewBuilderItem: ViewBuilderItem { .single(self) }
}
extension Array: ViewBuilderItemable where Element: BaseView {
    public var viewBuilderItem: ViewBuilderItem { .multiple(self) }
}
extension Optional: ViewBuilderItemable where Wrapped: BaseView {
    public var viewBuilderItem: ViewBuilderItem {
        switch self {
        case .none: return .none
        case .some(let value): return .single(value)
        }
    }
}
