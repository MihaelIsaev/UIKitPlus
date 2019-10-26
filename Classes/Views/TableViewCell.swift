import UIKit

open class TableViewCell: UITableViewCell, DeclarativeProtocol, DeclarativeProtocolInternal, Cellable {
    public var declarativeView: TableViewCell { self }
    public lazy var properties = Properties<TableViewCell>()
    lazy var _properties = PropertiesInternal()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
