import UIKit

open class View: UIView, UIViewable, DeclarativeProtocolInternal {
    public var declarativeView: View { self }
    public lazy var properties = Properties<View>()
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
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        _setup()
        body { block().viewBuilderItems }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    public convenience init () {
        self.init(frame: .zero)
    }
    
    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        buildView()
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
    
    open func buildView() {}
    
    // MARK: Touches
    
    public typealias TouchClosure = (Set<UITouch>, UIEvent?) -> Void
    
    private var _touchesBegan: TouchClosure?
    private var _touchesMoved: TouchClosure?
    private var _touchesEnded: TouchClosure?
    private var _touchesCancelled: TouchClosure?
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping TouchClosure) -> Self {
        _touchesBegan = closure
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping TouchClosure) -> Self {
        _touchesBegan = closure
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping TouchClosure) -> Self {
        _touchesBegan = closure
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping TouchClosure) -> Self {
        _touchesBegan = closure
        return self
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _touchesBegan?(touches, event)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        _touchesMoved?(touches, event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        _touchesEnded?(touches, event)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        _touchesCancelled?(touches, event)
    }
}

// MARK: Convenience Initializers

extension View {
    public static func inline(_ v: () -> UIView) -> View {
        .init(inline: v())
    }
    
    public convenience init (_ innerView: UIView) {
        self.init()
        body { innerView }
    }
    
    public convenience init (inline inlineView: UIView) {
        self.init()
        inlineView.translatesAutoresizingMaskIntoConstraints = false
        body { inlineView }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: inlineView.leadingAnchor),
            trailingAnchor.constraint(equalTo: inlineView.trailingAnchor),
            topAnchor.constraint(equalTo: inlineView.topAnchor),
            bottomAnchor.constraint(equalTo: inlineView.bottomAnchor)
        ])
    }
    
    public convenience init <V>(_ innerView: () -> V) where V: DeclarativeProtocol {
        self.init()
        body { innerView().declarativeView }
    }
    
    @discardableResult
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        body {
            block().viewBuilderItems
        }
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> View {
        View(block: block)
    }
}
