import UIKit

open class VisualEffectView: UIVisualEffectView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: VisualEffectView { self }
    public lazy var properties = Properties<VisualEffectView>()
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
        VisualEffectView(effect)
    }
}
