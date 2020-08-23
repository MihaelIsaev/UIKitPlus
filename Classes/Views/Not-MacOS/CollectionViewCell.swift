#if !os(macOS)
import UIKit

public typealias CollectionCell = CollectionViewCell

public typealias UCollectionViewCell = CollectionViewCell
open class CollectionViewCell: UICollectionViewCell, AnyDeclarativeProtocol, DeclarativeProtocolInternal, Cellable {
    public var declarativeView: CollectionViewCell { self }
    public lazy var properties = Properties<CollectionViewCell>()
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
    
    var __height: State<CGFloat> { _height }
    var __width: State<CGFloat> { _width }
    var __top: State<CGFloat> { _top }
    var __leading: State<CGFloat> { _leading }
    var __left: State<CGFloat> { _left }
    var __trailing: State<CGFloat> { _trailing }
    var __right: State<CGFloat> { _right }
    var __bottom: State<CGFloat> { _bottom }
    var __centerX: State<CGFloat> { _centerX }
    var __centerY: State<CGFloat> { _centerY }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }
    
    open func buildView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
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
#endif
