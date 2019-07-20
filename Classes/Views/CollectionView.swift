import UIKit

open class CollectionView: UICollectionView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: CollectionView { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    static var defaultLayout: UICollectionViewFlowLayout {
        return CollectionViewFlowLayout().itemSize(50).minimumInteritemSpacing(5).minimumLineSpacing(5)
    }
    
    public convenience init (_ layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    public convenience init () {
        self.init(frame: .zero, collectionViewLayout: CollectionView.defaultLayout)
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
    
    // MARK: ContentInsetAdjustment
    
    @discardableResult
    public func contentInsetAdjustment(_ mode: ContentInsetAdjustment) -> Self {
        if #available(iOS 11.0, *) {
            guard let mode = ContentInsetAdjustmentBehavior(rawValue: mode.rawValue) else { return self }
            contentInsetAdjustmentBehavior = mode
        }
        return self
    }
    
    // MARK: Paging
    
    @discardableResult
    public func paging(_ enabled: Bool) -> Self {
        isPagingEnabled = enabled
        return self
    }
    
    // MARK: Scrolling
    
    @discardableResult
    public func scrolling(_ enabled: Bool) -> Self {
        isScrollEnabled = enabled
        return self
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
    public func contentInset(_ insets: UIEdgeInsets) -> Self {
        contentInset = insets
        return self
    }
    
    @discardableResult
    public func contentInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        return contentInset(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    // MARK: Scroll Indicator Inset
    
    @discardableResult
    public func scrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
        scrollIndicatorInsets = insets
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        return scrollIndicatorInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    // MARK: Delegate
    
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    // MARK: Delegate
    
    @discardableResult
    public func dataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
}
