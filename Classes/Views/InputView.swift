import UIKit

public typealias UInputView = InputView
open class InputView: UIInputView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public static var defaultKeyboardHeight: CGFloat = 216
    
    public var declarativeView: InputView { self }
    public lazy var properties = Properties<InputView>()
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
    
    public override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        _setup()
        buildView()
    }
    
    public init (_ inputViewStyle: UIInputView.Style = .default) {
        super.init(frame: .zero, inputViewStyle: inputViewStyle)
        _setup()
        buildView()
    }
    
    public init (_ inputViewStyle: UIInputView.Style = .default, @ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero, inputViewStyle: inputViewStyle)
        _setup()
        body { block() }
        buildView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func buildView() {}
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    private var _intrinsicContentSize: CGSize = .init(width: UIView.noIntrinsicMetric, height: InputView.defaultKeyboardHeight) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        return _intrinsicContentSize
    }
    
    @discardableResult
    public func intrinsicContentSize(w: CGFloat = UIView.noIntrinsicMetric, h: CGFloat = UIView.noIntrinsicMetric) -> Self {
        _intrinsicContentSize = .init(width: w, height: h)
        return self
    }
    
    @discardableResult
    public func intrinsicContentSize(_ value: CGFloat) -> Self {
        intrinsicContentSize(w: value, h: value)
    }
    
    /// Width for `intrinsicContentSize`
    @discardableResult
    public func contentWidth(_ value: CGFloat) -> Self {
        intrinsicContentSize(w: value)
    }
    
    /// Height for `intrinsicContentSize`
    @discardableResult
    public func contentHeight(_ value: CGFloat) -> Self {
        intrinsicContentSize(h: value)
    }
    
    @discardableResult
    public func allowsSelfSizing(_ value: Bool) -> Self {
        allowsSelfSizing = value
        return self
    }
}

// MARK: Convenience Initializers

extension InputView {
    public convenience init (_ innerView: UIView) {
        self.init()
        body { innerView }
    }
    
    public convenience init <V>(_ innerView: () -> V) where V: DeclarativeProtocol {
        self.init()
        body { innerView().declarativeView }
    }
    
    @discardableResult
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        body { block() }
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> InputView {
        InputView(block: block)
    }
}
