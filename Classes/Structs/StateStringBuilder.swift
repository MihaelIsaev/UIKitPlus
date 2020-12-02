import Foundation

@_functionBuilder public struct AnyStringBuilder {
    public typealias Handler = () -> AnyString
    
    public static func buildBlock() -> AnyString { "" }
    
    public static func buildBlock(_ string: AnyString...) -> AnyString {
        buildBlock(string)
    }
    
    public static func buildBlock(_ string: [AnyString]) -> AnyString {
        let attrString = AttrStr()
        string.onUpdate {
            attrString._attributedString = .init(attributedString: $0)
            attrString._updateHandler($0)
        }
        return attrString
    }
    
    public static func buildIf(_ content: AnyString?) -> AnyString {
        guard let content = content else { return "" }
        return content
    }
    
    public static func buildEither(first: AnyString) -> AnyString {
        first
    }

    public static func buildEither(second: AnyString) -> AnyString {
        second
    }
}
