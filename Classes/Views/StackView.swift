import UIKit

open class StackView: _StackView {
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
    var _constraints: DeclarativeConstraintsCollection = [:]
    
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
    
    // Mask: Axis
    
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> _StackView {
        self.alignment = alignment
        return self
    }
    
    // Mask: Axis
    
    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> _StackView {
        self.distribution = distribution
        return self
    }
    
    // Mask: Axis
    
    @discardableResult
    public func spacing(_ spacing: CGFloat) -> _StackView {
        self.spacing = spacing
        return self
    }
}
