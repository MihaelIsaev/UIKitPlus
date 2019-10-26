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
    
    var __height: State<CGFloat> { $height }
    var __width: State<CGFloat> { $width }
    var __top: State<CGFloat> { $top }
    var __leading: State<CGFloat> { $leading }
    var __left: State<CGFloat> { $left }
    var __trailing: State<CGFloat> { $trailing }
    var __right: State<CGFloat> { $right }
    var __bottom: State<CGFloat> { $bottom }
    var __centerX: State<CGFloat> { $centerX }
    var __centerY: State<CGFloat> { $centerY }
    
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

