import UIKit

public typealias CollectionCell = CollectionViewCell

open class CollectionViewCell: UICollectionViewCell, DeclarativeProtocol, DeclarativeProtocolInternal, Cellable {
    public var declarativeView: CollectionViewCell { self }
    public lazy var properties = Properties<CollectionViewCell>()
    lazy var _properties = PropertiesInternal()
    
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
