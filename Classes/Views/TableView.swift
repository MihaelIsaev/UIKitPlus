import UIKit

open class TableView: UITableView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TableView { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraints: DeclarativeConstraintsCollection = [:]
    
    public init (_ style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
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
