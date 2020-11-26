import UIKit

public typealias UControlView = ControlView
open class ControlView: UIControl, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: ControlView { self }
    public lazy var properties = Properties<ControlView>()
    lazy var _properties = PropertiesInternal()
    
    @UIKitPlus.UState public var height: CGFloat = 0
    @UIKitPlus.UState public var width: CGFloat = 0
    @UIKitPlus.UState public var top: CGFloat = 0
    @UIKitPlus.UState public var leading: CGFloat = 0
    @UIKitPlus.UState public var left: CGFloat = 0
    @UIKitPlus.UState public var trailing: CGFloat = 0
    @UIKitPlus.UState public var right: CGFloat = 0
    @UIKitPlus.UState public var bottom: CGFloat = 0
    @UIKitPlus.UState public var centerX: CGFloat = 0
    @UIKitPlus.UState public var centerY: CGFloat = 0
    
    var __height: UIKitPlus.UState<CGFloat> { $height }
    var __width: UIKitPlus.UState<CGFloat> { $width }
    var __top: UIKitPlus.UState<CGFloat> { $top }
    var __leading: UIKitPlus.UState<CGFloat> { $leading }
    var __left: UIKitPlus.UState<CGFloat> { $left }
    var __trailing: UIKitPlus.UState<CGFloat> { $trailing }
    var __right: UIKitPlus.UState<CGFloat> { $right }
    var __bottom: UIKitPlus.UState<CGFloat> { $bottom }
    var __centerX: UIKitPlus.UState<CGFloat> { $centerX }
    var __centerY: UIKitPlus.UState<CGFloat> { $centerY }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        buildView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func buildView() {}
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
}
