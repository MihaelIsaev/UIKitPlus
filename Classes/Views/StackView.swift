import UIKit

open class StackView: _StackView {
    public init (_ subviews: UIView...)  {
        super.init(frame: .zero)
        axis = .horizontal
        subviews.forEach { self.addArrangedSubview($0) }
    }
    
    public init (_ subviews: () -> [UIView])  {
        super.init(frame: .zero)
        axis = .horizontal
        subviews().forEach { self.addArrangedSubview($0) }
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func subviews(_ subviews: () -> [UIView]) -> StackView {
        return StackView(subviews)
    }
    
    // Mask: Axis
    
    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> StackView {
        self.axis = axis
        return self
    }
}

open class _StackView: UIStackView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: _StackView { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
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
