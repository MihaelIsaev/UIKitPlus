import UIKit

@_functionBuilder public struct ViewBuilder {
    public typealias SingleView = () -> ViewBuilderItem
    
    /// Builds an empty view from an block containing no statements, `{ }`.
    public static func buildBlock() -> ViewBuilderItem {
        return []
    }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through unmodified.
    public static func buildBlock(_ attrs: ViewBuilderItem...) -> ViewBuilderItem {
        return ViewBuilderItems(items: attrs.flatMap { $0.viewBuilderItems })
    }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through unmodified.
    public static func buildBlock(_ attrs: [ViewBuilderItem]) -> ViewBuilderItem {
        return ViewBuilderItems(items: attrs.flatMap { $0.viewBuilderItems })
    }
    
    /// Provides support for "if" statements in multi-statement closures, producing an `Optional` view
    /// that is visible only when the `if` condition evaluates `true`.
    public static func buildIf(_ content: ViewBuilderItem?) -> ViewBuilderItem {
        guard let content = content else { return [] }
        return content
    }
    
    /// Provides support for "if" statements in multi-statement closures, producing
    /// ConditionalContent for the "then" branch.
    public static func buildEither(first: ViewBuilderItem) -> ViewBuilderItem {
        return first
    }

    /// Provides support for "if-else" statements in multi-statement closures, producing
    /// ConditionalContent for the "else" branch.
    public static func buildEither(second: ViewBuilderItem) -> ViewBuilderItem {
        return second
    }
}
