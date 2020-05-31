import UIKit

public struct ViewBuilderItems: ViewBuilderItemable {
    var items: [ViewBuilderItemable] = []
    
    public var viewBuilderItem: ViewBuilderItem {
        .nested(items)
    }
}
