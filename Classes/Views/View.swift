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

// MARK: Convenience Initializers

extension View {
    public convenience init (_ innerView: UIView) {
        self.init()
        addSubview(innerView)
    }
    
    public convenience init <V>(_ innerView: () -> V) where V: DeclarativeProtocol {
        self.init()
        addSubview(innerView().declarativeView)
    }
    
    public func subviews(_ subviews: () -> [UIView]) -> View {
        subviews().forEach { addSubview($0) }
        return self
    }
    
    public static func subviews(_ subviews: () -> [UIView]) -> View {
        return View().subviews(subviews)
    }
}
