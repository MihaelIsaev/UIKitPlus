import UIKit

open class ActivityIndicator: UIActivityIndicatorView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: ActivityIndicator { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
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
    
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        self.color = color
        return self
    }
    
    @discardableResult
    public func color(_ number: Int) -> Self {
        self.color = number.color
        return self
    }
    
    @discardableResult
    public func hidesWhenStopped() -> Self {
        self.hidesWhenStopped = true
        return self
    }
    
    @discardableResult
    public func hidesWhenStopped(_ value: Bool = true) -> Self {
        self.hidesWhenStopped = value
        return self
    }
    
    @discardableResult
    public func animate() -> Self {
        startAnimating()
        return self
    }
}

