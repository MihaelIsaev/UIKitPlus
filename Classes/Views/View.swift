import UIKit

public typealias UView = View
open class View: UIView, UIViewable, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: View { self }
    public lazy var properties = Properties<View>()
    lazy var _properties = PropertiesInternal()
    
    @UState public var height: CGFloat = 0
    @UState public var width: CGFloat = 0
    @UState public var top: CGFloat = 0
    @UState public var leading: CGFloat = 0
    @UState public var left: CGFloat = 0
    @UState public var trailing: CGFloat = 0
    @UState public var right: CGFloat = 0
    @UState public var bottom: CGFloat = 0
    @UState public var centerX: CGFloat = 0
    @UState public var centerY: CGFloat = 0
    
    var __height: UState<CGFloat> { _height }
    var __width: UState<CGFloat> { _width }
    var __top: UState<CGFloat> { _top }
    var __leading: UState<CGFloat> { _leading }
    var __left: UState<CGFloat> { _left }
    var __trailing: UState<CGFloat> { _trailing }
    var __right: UState<CGFloat> { _right }
    var __bottom: UState<CGFloat> { _bottom }
    var __centerX: UState<CGFloat> { _centerX }
    var __centerY: UState<CGFloat> { _centerY }
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        _setup()
        body { block() }
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
    
    typealias TouchClosure = (Set<UITouch>, UIEvent?) -> Void
    
    var _touchesBegan: TouchClosure?
    var _touchesMoved: TouchClosure?
    var _touchesEnded: TouchClosure?
    var _touchesCancelled: TouchClosure?
    
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
    
    public convenience init (_ innerView: UIView, with: ((UIView) -> Void)? = nil) {
        self.init()
        body { innerView }
        with?(self)
    }
    
    public convenience init (inline inlineView: UIView, with: ((UIView) -> Void)? = nil) {
        self.init()
        
        inlineView.translatesAutoresizingMaskIntoConstraints = false
        body { inlineView }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: inlineView.leadingAnchor),
            trailingAnchor.constraint(equalTo: inlineView.trailingAnchor),
            topAnchor.constraint(equalTo: inlineView.topAnchor),
            bottomAnchor.constraint(equalTo: inlineView.bottomAnchor)
        ])
        with?(self)
    }
    
    public convenience init <V>(_ innerView: () -> V, with: ((UIView) -> Void)? = nil) where V: DeclarativeProtocol {
        self.init()

        body { innerView().declarativeView }
        with?(self)
    }
    
    @discardableResult
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        body { block() }
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> View {
        View(block: block)
    }
}

// MARK: Touches

extension View {
    /// Began
    @discardableResult
    public func touchesBegan(_ closure: @escaping () -> Void) -> Self {
        _touchesBegan = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesBegan = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesBegan = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesBegan(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesBegan = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Moved
    @discardableResult
    public func touchesMoved(_ closure: @escaping () -> Void) -> Self {
        _touchesMoved = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesMoved = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesMoved = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesMoved(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesMoved = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Ended
    @discardableResult
    public func touchesEnded(_ closure: @escaping () -> Void) -> Self {
        _touchesEnded = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesEnded = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesEnded = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesEnded(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesEnded = { set, event in
            closure(self, set, event)
        }
        return self
    }
    
    /// Cancelled
    @discardableResult
    public func touchesCancelled(_ closure: @escaping () -> Void) -> Self {
        _touchesCancelled = { _,_ in closure() }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self) -> Void) -> Self {
        _touchesCancelled = { _,_ in closure(self) }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>) -> Void) -> Self {
        _touchesCancelled = { set, _ in
            closure(self, set)
        }
        return self
    }
    
    @discardableResult
    public func touchesCancelled(_ closure: @escaping (Self, Set<UITouch>, UIEvent?) -> Void) -> Self {
        _touchesCancelled = { set, event in
            closure(self, set, event)
        }
        return self
    }
}
