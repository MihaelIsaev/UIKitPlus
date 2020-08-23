#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, renamed: "VStack")
public typealias VStackView = VStack

public typealias UVStack = VStack
open class VStack: _StackView {
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        #if os(macOS)
        orientation = .vertical
        #else
        axis = .vertical
        #endif
        add(item: block())
    }
    
    public override init () {
        super.init(frame: .zero)
        #if os(macOS)
        orientation = .vertical
        #else
        axis = .vertical
        #endif
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        add(item: block())
        return self
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> VStack {
        .init(block: block)
    }
}
