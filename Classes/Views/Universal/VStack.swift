#if os(macOS)
import AppKit
#else
import UIKit
#endif

open class UVStack: _StackView {
    public init (@BodyBuilder block: BodyBuilder.SingleView) {
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
    
    public func subviews(@BodyBuilder block: BodyBuilder.SingleView) -> Self {
        add(item: block())
        return self
    }
    
    public static func subviews(@BodyBuilder block: BodyBuilder.SingleView) -> UVStack {
        .init(block: block)
    }
}
