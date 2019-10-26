import UIKit

open class StackView: _StackView {
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        block().viewBuilderItems.forEach { addArrangedSubview($0) }
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> StackView {
        block().viewBuilderItems.forEach { addArrangedSubview($0) }
        return self
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> StackView {
        StackView(block: block)
    }
    
    // Mask: Axis
    
    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> StackView {
        self.axis = axis
        return self
    }
}

open class _StackView: UIStackView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: _StackView { self }
    public lazy var properties = Properties<_StackView>()
    lazy var _properties = PropertiesInternal()
    
    public init () {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    // Mask: Alignment
    
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    // Mask: Distribution
    
    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
    // Mask: Spacing
    
    @discardableResult
    public func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
}
