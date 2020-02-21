import UIKit

public protocol ListableBuilderItem {
    var listableBuilderItems: [Listable] { get }
}
struct EmptyListableBuilderItem: ListableBuilderItem {
    var listableBuilderItems: [Listable] { [] }
}
extension Array: ListableBuilderItem where Element: Listable {
    public var listableBuilderItems: [Listable] { self }
}
extension Optional: ListableBuilderItem where Wrapped: Listable {
    public var listableBuilderItems: [Listable] {
        switch self {
        case .none: return []
        case .some(let value): return [value]
        }
    }
}
