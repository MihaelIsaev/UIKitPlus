import UIKit

@_functionBuilder public struct ListableBuilder {
    public typealias SingleView = () -> ListableBuilderItem
    
    /// Builds an empty view from an block containing no statements, `{ }`.
    public static func buildBlock() -> ListableBuilderItem {
        EmptyListableBuilderItem()
    }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through unmodified.
    public static func buildBlock(_ attrs: ListableBuilderItem...) -> ListableBuilderItem {
        buildBlock(attrs)
    }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through unmodified.
    public static func buildBlock(_ attrs: [ListableBuilderItem]) -> ListableBuilderItem {
        ListableBuilderItems(items: attrs.flatMap { $0.listableBuilderItems })
    }
    
    /// Provides support for "if" statements in multi-statement closures, producing an `Optional` view
    /// that is visible only when the `if` condition evaluates `true`.
    public static func buildIf(_ content: ListableBuilderItem?) -> ListableBuilderItem {
        guard let content = content else { return EmptyListableBuilderItem() }
        return content
    }
    
    /// Provides support for "if" statements in multi-statement closures, producing
    /// ConditionalContent for the "then" branch.
    public static func buildEither(first: ListableBuilderItem) -> ListableBuilderItem {
        first
    }

    /// Provides support for "if-else" statements in multi-statement closures, producing
    /// ConditionalContent for the "else" branch.
    public static func buildEither(second: ListableBuilderItem) -> ListableBuilderItem {
        second
    }
}
