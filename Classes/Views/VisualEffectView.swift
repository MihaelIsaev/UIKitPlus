import UIKit

open class VisualEffectView: UIVisualEffectView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: VisualEffectView { self }
    public lazy var properties = Properties<VisualEffectView>()
    lazy var _properties = PropertiesInternal()
    
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
    public func effect(_ effect: UIVisualEffect?) -> Self {
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
