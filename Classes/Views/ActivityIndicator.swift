import UIKit

open class ActivityIndicator: UIActivityIndicatorView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: ActivityIndicator { self }
    public lazy var properties = Properties<ActivityIndicator>()
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
    
    /// See `AnyForeacheableView`
    public lazy var isVisibleInList: Bool = !isHidden
    
    public override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init(coder: NSCoder) {
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
    
    // MARK: - color
    
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        self.color = color
        return self
    }
    
    @discardableResult
    public func color(_ number: Int) -> Self {
        color(number.color)
    }
    
    @discardableResult
    public func color(_ binding: State<UIColor>) -> Self {
        binding.listen { self.color($0) }
        return color(binding.wrappedValue)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.color(expressable.value()) }
        return color(expressable.value())
    }
    
    @discardableResult
    public func color(_ binding: State<Int>) -> Self {
        binding.listen { self.color($0) }
        return color(binding.wrappedValue)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.color(expressable.value()) }
        return color(expressable.value())
    }
    
    @discardableResult
    public func started(_ value: Bool) -> Self {
        if value {
            startAnimating()
        } else {
            stopAnimating()
        }
        return self
    }
    
    @discardableResult
    public func started(_ binding: State<Bool>) -> Self {
        binding.listen { self.started($0) }
        return started(binding.wrappedValue)
    }
    
    @discardableResult
    public func started<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        started(expressable.unwrap())
    }
    
    @discardableResult
    public func hidesWhenStopped() -> Self {
        self.hidesWhenStopped = true
        return self
    }
    
    @discardableResult
    public func hidesWhenStopped(_ value: Bool = true) -> Self {
        self.hidesWhenStopped = value
        return self
    }
    
    @discardableResult
    public func animate() -> Self {
        startAnimating()
        return self
    }
}

