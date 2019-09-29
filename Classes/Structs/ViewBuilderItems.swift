public struct ViewBuilderItems: ViewBuilderItem {
    public let items: [UIView]
    
    public init (items: [UIView]) {
        self.items = items
    }
    
    public var viewBuilderItems: [UIView] { items }
}
