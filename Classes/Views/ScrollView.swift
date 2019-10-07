import UIKit

open class ScrollView: UIScrollView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: ScrollView { self }
    public lazy var properties = Properties<ScrollView>()
    lazy var _properties = PropertiesInternal()
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        _setup()
        addSubview(block().viewBuilderItems)
    }
    
    public init () {
        super.init(frame: .zero)
        _setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    private func _setup() {
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
    public func delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
}

// MARK: Convenience Initializers

extension ScrollView {
    public convenience init (_ innerView: UIView) {
        self.init()
        addSubview(innerView)
    }
    
    public convenience init <V>(_ innerView: () -> V) where V: DeclarativeProtocol {
        self.init()
        addSubview(innerView().declarativeView)
    }
    
    public func subviews(_ subviews: () -> [UIView]) -> Self {
        subviews().forEach { addSubview($0) }
        return self
    }
    
    public static func subviews(_ subviews: () -> [UIView]) -> View {
        return View().subviews(subviews)
    }
}
