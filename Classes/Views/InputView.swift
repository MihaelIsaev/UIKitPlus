import UIKit

open class InputView: UIInputView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public static var defaultKeyboardHeight: CGFloat = 216
    
    public var declarativeView: InputView { self }
    public lazy var properties = Properties<InputView>()
    lazy var _properties = PropertiesInternal()
    
    public override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        translatesAutoresizingMaskIntoConstraints = false
        buildView()
    }
    
    public init (_ inputViewStyle: UIInputView.Style = .default) {
        super.init(frame: .zero, inputViewStyle: inputViewStyle)
        translatesAutoresizingMaskIntoConstraints = false
        buildView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return intrinsicContentSize(w: value, h: value)
    }
    
    /// Width for `intrinsicContentSize`
    @discardableResult
    public func contentWidth(_ value: CGFloat) -> Self {
        return intrinsicContentSize(w: value)
    }
    
    /// Height for `intrinsicContentSize`
    @discardableResult
    public func contentHeight(_ value: CGFloat) -> Self {
        return intrinsicContentSize(h: value)
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
        addSubview(innerView)
    }
    
    public convenience init <V>(_ innerView: () -> V) where V: DeclarativeProtocol {
        self.init()
        addSubview(innerView().declarativeView)
    }
    
    @discardableResult
    public func subviews(_ subviews: () -> [UIView]) -> Self {
        subviews().forEach { addSubview($0) }
        return self
    }
    
    public static func subviews(_ subviews: () -> [UIView]) -> View {
        return View().subviews(subviews)
    }
}
