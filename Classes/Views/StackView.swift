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
    
    @State public var height: CGFloat = 0
    @State public var width: CGFloat = 0
    @State public var top: CGFloat = 0
    @State public var leading: CGFloat = 0
    @State public var left: CGFloat = 0
    @State public var trailing: CGFloat = 0
    @State public var right: CGFloat = 0
    @State public var bottom: CGFloat = 0
    @State public var centerX: CGFloat = 0
    @State public var centerY: CGFloat = 0
    
    var __height: State<CGFloat> { $height }
    var __width: State<CGFloat> { $width }
    var __top: State<CGFloat> { $top }
    var __leading: State<CGFloat> { $leading }
    var __left: State<CGFloat> { $left }
    var __trailing: State<CGFloat> { $trailing }
    var __right: State<CGFloat> { $right }
    var __bottom: State<CGFloat> { $bottom }
    var __centerX: State<CGFloat> { $centerX }
    var __centerY: State<CGFloat> { $centerY }
    
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
