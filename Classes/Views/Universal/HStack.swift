#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, renamed: "HStack")
public typealias HStackView = HStack

public typealias UHStack = HStack
open class HStack: _StackView {
    public init (@BodyBuilder block: BodyBuilder.SingleView) {
        super.init(frame: .zero)
        #if os(macOS)
        orientation = .horizontal
        #else
        axis = .horizontal
        #endif
        add(item: block())
    }
    
    public override init () {
        super.init(frame: .zero)
        #if os(macOS)
        orientation = .horizontal
        #else
        axis = .horizontal
        #endif
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func subviews(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        add(item: block())
        return self
    }
    
    public static func subviews(@BodyBuilder block: BodyBuilder.SingleView) -> HStack {
        .init(block: block)
    }
}
