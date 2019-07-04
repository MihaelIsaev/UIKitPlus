import UIKit

open class VisualEffectView: UIVisualEffectView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: VisualEffectView { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init(_ effect: UIVisualEffect?) {
        super.init(effect: effect)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init () {
        super.init(effect: nil)
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
    public func effect(_ effect: UIVisualEffect?) -> VisualEffectView {
        self.effect = effect
        return self
    }
}

// MARK: Convenience Initializers

extension UIVisualEffect {
    static func effect(_ effect: UIVisualEffect?) -> VisualEffectView {
        return VisualEffectView(effect)
    }
}
