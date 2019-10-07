import UIKit

open class TableView: UITableView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TableView { self }
    public lazy var properties = Properties<TableView>()
    lazy var _properties = PropertiesInternal()
    
    
    public init (_ style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        buildView()
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        buildView()
    }
    
    func buildView() {
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
    
    // MARK: Indicators
    
    @discardableResult
    public func hideIndicator(_ indicators: NSLayoutConstraint.Axis...) -> Self {
        if indicators.contains(.horizontal) {
            showsHorizontalScrollIndicator = false
        }
        if indicators.contains(.vertical) {
            showsVerticalScrollIndicator = false
        }
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideAllIndicators() -> Self {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        return self
    }
    
    // MARK: Content Inset
    
    @discardableResult
    public func contentInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        contentInset = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    public func contentInset(x: CGFloat) -> Self {
        return contentInset(top: 0, left: x, right: x, bottom: 0)
    }
    
    @discardableResult
    public func contentInset(y: CGFloat) -> Self {
        return contentInset(top: y, left: 0, right: 0, bottom: y)
    }
    
    @discardableResult
    public func contentInset( _ value: CGFloat) -> Self {
        return contentInset(top: value, left: value, right: value, bottom: value)
    }
    
    @discardableResult
    public func scrollIndicatorInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        scrollIndicatorInsets = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(x: CGFloat) -> Self {
        return scrollIndicatorInsets(top: 0, left: x, right: x, bottom: 0)
    }
    
    @discardableResult
    public func scrollIndicatorInsets(y: CGFloat) -> Self {
        return scrollIndicatorInsets(top: y, left: 0, right: 0, bottom: y)
    }
    
    @discardableResult
    public func scrollIndicatorInsets( _ value: CGFloat) -> Self {
        return scrollIndicatorInsets(top: value, left: value, right: value, bottom: value)
    }
    
    @discardableResult
    public func contentOffset(_ value: CGFloat) -> Self {
        contentOffset = .init(x: 0, y: value)
        return self
    }
    
    @discardableResult
    public func automaticDimension(_ estimatedRowHeight: CGFloat = 44) -> Self {
        rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimatedRowHeight
        return self
    }
    
    @discardableResult
    public func delegate(_ value: UITableViewDelegate) -> Self {
        delegate = value
        return self
    }
    
    @discardableResult
    public func dataSource(_ value: UITableViewDataSource) -> Self {
        dataSource = value
        return self
    }
    
    @discardableResult
    public func separatorColor(_ value: UIColor) -> Self {
        separatorColor = value
        return self
    }
    
    @discardableResult
    public func separatorStyle(_ value: UITableViewCell.SeparatorStyle) -> Self {
        separatorStyle = value
        return self
    }
    
    @discardableResult
    public func separatorInset(_ value: UIEdgeInsets) -> Self {
        separatorInset = value
        return self
    }
    
    @discardableResult
    public func separatorInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        separatorInset = .init(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
