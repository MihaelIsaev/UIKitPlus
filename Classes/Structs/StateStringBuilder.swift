import Foundation

@_functionBuilder public struct StateStringBuilder {
    public typealias Handler = () -> String
    
    public static func buildBlock() -> String { "" }
    
    public static func buildBlock(_ string: String...) -> String {
        buildBlock(string)
    }
    
    public static func buildBlock(_ string: [String]) -> String {
        string.joined()
    }
    
    public static func buildIf(_ content: String?) -> String {
        guard let content = content else { return "" }
        return content
    }
    
    public static func buildEither(first: String) -> String {
        first
    }

    public static func buildEither(second: String) -> String {
        second
    }
}

@_functionBuilder public struct StateAttrStringBuilder {
    public typealias Handler = () -> AttributedString
    
    public static func buildBlock() -> AttributedString { AttributedString("") }
    
    public static func buildBlock(_ string: AttributedString...) -> AttributedString {
        buildBlock(string)
    }
    
    public static func buildBlock(_ string: [AttributedString]) -> AttributedString {
        string.joined()
    }
    
    public static func buildIf(_ content: AttributedString?) -> AttributedString {
        guard let content = content else { return AttributedString("") }
        return content
    }
    
    public static func buildEither(first: AttributedString) -> AttributedString {
        first
    }

    public static func buildEither(second: AttributedString) -> AttributedString {
        second
    }
}
