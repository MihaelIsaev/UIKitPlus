import UIKit

@_functionBuilder public struct ViewBuilder {
    public typealias Result = ViewBuilderItemable
    public typealias SingleView = () -> Result
    
    /// Builds an empty view from an block containing no statements, `{ }`.
    public static func buildBlock() -> Result { [] }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through unmodified.
    public static func buildBlock(_ attrs: ViewBuilderItemable...) -> Result {
        buildBlock(attrs)
    }
    
    /// Passes a single view written as a child view (e..g, `{ Text("Hello") }`) through unmodified.
    public static func buildBlock(_ attrs: [ViewBuilderItemable]) -> Result {
        ViewBuilderItems(items: attrs)
    }
    
    /// Provides support for "if" statements in multi-statement closures, producing an `Optional` view
    /// that is visible only when the `if` condition evaluates `true`.
    public static func buildIf(_ content: ViewBuilderItemable?) -> Result {
        guard let content = content else { return EmptyViewBuilderItem() }
        return content
    }
    
    /// Provides support for "if" statements in multi-statement closures, producing
    /// ConditionalContent for the "then" branch.
    public static func buildEither(first: ViewBuilderItemable) -> Result {
        first
    }

    /// Provides support for "if-else" statements in multi-statement closures, producing
    /// ConditionalContent for the "else" branch.
    public static func buildEither(second: ViewBuilderItemable) -> Result {
        second
    }
}

extension UIViewController: ViewBuilderItemable {
    public var viewBuilderItem: ViewBuilderItem {
        .single(View(inline: view).edgesToSuperview())
    }
}
