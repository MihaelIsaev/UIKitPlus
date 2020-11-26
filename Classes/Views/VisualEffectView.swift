import UIKit

public typealias UVisualEffectView = VisualEffectView
open class VisualEffectView: UIVisualEffectView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: VisualEffectView { self }
    public lazy var properties = Properties<VisualEffectView>()
    lazy var _properties = PropertiesInternal()
    
    @UState public var height: CGFloat = 0
    @UState public var width: CGFloat = 0
    @UState public var top: CGFloat = 0
    @UState public var leading: CGFloat = 0
    @UState public var left: CGFloat = 0
    @UState public var trailing: CGFloat = 0
    @UState public var right: CGFloat = 0
    @UState public var bottom: CGFloat = 0
    @UState public var centerX: CGFloat = 0
    @UState public var centerY: CGFloat = 0
    
    var __height: UState<CGFloat> { _height }
    var __width: UState<CGFloat> { _width }
    var __top: UState<CGFloat> { _top }
    var __leading: UState<CGFloat> { _leading }
    var __left: UState<CGFloat> { _left }
    var __trailing: UState<CGFloat> { _trailing }
    var __right: UState<CGFloat> { _right }
    var __bottom: UState<CGFloat> { _bottom }
    var __centerX: UState<CGFloat> { _centerX }
    var __centerY: UState<CGFloat> { _centerY }
    
    var _defaultEffect, _darkEffect: UIVisualEffect?
    
    public override init(effect: UIVisualEffect?) {
        self._defaultEffect = effect
        super.init(effect: effect)
        switchEffect()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init(_ effect: UIVisualEffect?, _ darkEffect: UIVisualEffect? = nil) {
        self._defaultEffect = effect
        self._darkEffect = darkEffect
        super.init(effect: effect)
        switchEffect()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init () {
        super.init(effect: nil)
        switchEffect()
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
        self._defaultEffect = effect
        switchEffect()
        return self
    }
    
    @discardableResult
    public func darkEffect(_ effect: UIVisualEffect?) -> Self {
        self._darkEffect = effect
        switchEffect()
        return self
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        switchEffect()
    }
    
    var isDark: Bool {
        if #available(iOS 12.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
    
    private func switchEffect() {
        if isDark, let de = _darkEffect {
            effect = de
            return
        }
        effect = _defaultEffect
    }
}

// MARK: Convenience Initializers

extension UIVisualEffect {
    static func effect(_ effect: UIVisualEffect?) -> VisualEffectView {
        VisualEffectView(effect)
    }
}
