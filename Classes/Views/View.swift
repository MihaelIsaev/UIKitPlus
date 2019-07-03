import UIKit

open class View: UIView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: View { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraints: DeclarativeConstraintsCollection = [:]
    
    public init () {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init (_ innerView: UIView) {
        super.init(frame: .zero)
        addSubview(innerView)
    }
    
    public init (_ innerView: () -> (UIView)) {
        super.init(frame: .zero)
        addSubview(innerView())
    }
    
    public init (_ innerViews: () -> [UIView]) {
        super.init(frame: .zero)
        innerViews().forEach { addSubview($0) }
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
}
