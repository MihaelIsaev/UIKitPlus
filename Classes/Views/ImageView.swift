import UIKit

open class Image: UIImageView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Image { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public init (_ named: String) {
        super.init(frame: .zero)
        image = UIImage(named: named)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init (_ image: UIImage?) {
        super.init(frame: .zero)
        self.image = image
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
    public func mode(_ mode: UIView.ContentMode) -> Image {
        contentMode = mode
        return self
    }
    
    @discardableResult
    public func clipsToBounds(_ value: Bool) -> Image {
        clipsToBounds = value
        return self
    }
}
