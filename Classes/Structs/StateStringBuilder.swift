import Foundation

@_functionBuilder public struct StateStringBuilder {
    public typealias Handler = () -> String
    
    public static func buildBlock() -> String {
        return ""
    }
    
    public static func buildBlock(_ string: String...) -> String {
        return string.joined()
    }
    
    public static func buildBlock(_ string: [String]) -> String {
        return string.joined()
    }
    
    public static func buildIf(_ content: String?) -> String {
        guard let content = content else { return "" }
        return content
    }
    
    public static func buildEither(first: String) -> String {
        return first
    }

    public static func buildEither(second: String) -> String {
        return second
    }
}
