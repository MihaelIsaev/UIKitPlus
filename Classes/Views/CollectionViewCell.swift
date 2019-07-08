import UIKit

open class CollectionViewCell: UICollectionViewCell, DeclarativeProtocol, DeclarativeProtocolInternal, Cellable {
    public var declarativeView: CollectionViewCell { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }
    
    open func buildView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
