import UIKit

@available(*, deprecated, renamed: "VStack")
public typealias VStackView = VStack

open class VStack: _StackView {
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        axis = .vertical
        block().viewBuilderItems.forEach { addArrangedSubview($0) }
    }
    
    public override init () {
        super.init(frame: .zero)
        axis = .vertical
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        block().viewBuilderItems.forEach { addArrangedSubview($0) }
        return self
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> VStack {
        .init(block: block)
    }
}
