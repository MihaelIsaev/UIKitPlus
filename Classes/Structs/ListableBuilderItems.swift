import UIKit

public struct ListableBuilderItems: ListableBuilderItem {
    public let items: [Listable]
    
    public init (items: [Listable]) {
        self.items = items
    }
    
    public var listableBuilderItems: [Listable] { items }
}
