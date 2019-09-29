import UIKit

open class View: UIView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: View { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        _setup()
        addSubview(block().viewBuilderItems)
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
    
    // MARK: Single Tap
    
    private var _tapAction: ()->Void = {}
    private var _tapActionWithView: (View)->Void = { _ in }
    
    @discardableResult
    public func tapAction(_ action: @escaping ()->Void) -> Self {
        _tapAction = action
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        return self
    }
    
    @discardableResult
    public func tapAction(_ action: @escaping (View)->Void) -> Self {
        _tapActionWithView = action
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapWithView)))
        return self
    }
    
    @objc
    private func tap() {
        _tapAction()
    }
    
    @objc
    private func tapWithView() {
        _tapActionWithView(self)
    }
}

// MARK: Convenience Initializers

extension View {
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
