#if os(macOS)
import AppKit
#else
import UIKit
#endif

public struct ViewBuilderItems: ViewBuilderItemable {
    var items: [ViewBuilderItemable] = []
    
    public var viewBuilderItem: ViewBuilderItem {
        .nested(items)
    }
}
