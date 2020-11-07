#if os(macOS)
import AppKit

open class UPopUpButton: NSPopUpButton, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: UPopUpButton { self }
    public lazy var properties = Properties<UPopUpButton>()
    lazy var _properties = PropertiesInternal()
    
    @UIKitPlus.State public var height: CGFloat = 0
    @UIKitPlus.State public var width: CGFloat = 0
    @UIKitPlus.State public var top: CGFloat = 0
    @UIKitPlus.State public var leading: CGFloat = 0
    @UIKitPlus.State public var left: CGFloat = 0
    @UIKitPlus.State public var trailing: CGFloat = 0
    @UIKitPlus.State public var right: CGFloat = 0
    @UIKitPlus.State public var bottom: CGFloat = 0
    @UIKitPlus.State public var centerX: CGFloat = 0
    @UIKitPlus.State public var centerY: CGFloat = 0
    
    var __height: UIKitPlus.State<CGFloat> { $height }
    var __width: UIKitPlus.State<CGFloat> { $width }
    var __top: UIKitPlus.State<CGFloat> { $top }
    var __leading: UIKitPlus.State<CGFloat> { $leading }
    var __left: UIKitPlus.State<CGFloat> { $left }
    var __trailing: UIKitPlus.State<CGFloat> { $trailing }
    var __right: UIKitPlus.State<CGFloat> { $right }
    var __bottom: UIKitPlus.State<CGFloat> { $bottom }
    var __centerX: UIKitPlus.State<CGFloat> { $centerX }
    var __centerY: UIKitPlus.State<CGFloat> { $centerY }
    
    lazy var _bezelStyleState: State<NSButton.BezelStyle> = .init(wrappedValue: bezelStyle)
//    lazy var _buttonTypeState: State<NSButton.ButtonType> = .init(wrappedValue: .momentaryPushIn)
    lazy var _ignoreMultiClickState: State<Bool> = .init(wrappedValue: ignoresMultiClick)
    lazy var _continuousState: State<Bool> = .init(wrappedValue: isContinuous)
    lazy var _refuseFirstResponderState: State<Bool> = .init(wrappedValue: refusesFirstResponder)
    lazy var _borderedState: State<Bool> = .init(wrappedValue: isBordered)
    
    @discardableResult
    public init(_ v: Menu) {
        super.init(frame: .zero, pullsDown: false)
        _setup()
        menu(v)
    }
    
    @discardableResult
    public init(@MenuBuilder content: @escaping MenuBuilder.Block) {
        super.init(frame: .zero, pullsDown: false)
        _setup()
        menu(content: content)
    }
    
    @discardableResult
    public init(@MenuBuilder content: @escaping (Menu) -> MenuBuilderContent) {
        super.init(frame: .zero, pullsDown: false)
        _setup()
        menu(content: content)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        target = self
        action = #selector(pushHandler)
    }
    
    open override func layout() {
        super.layout()
        onLayoutSubviews()
    }
    
    open override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        movedToSuperview()
    }
    
    // MARK: Action
    
    private var actionHandler: (() -> Void)?
    private var actionSelfHandler: ((UPopUpButton) -> Void)?
    
    @objc func pushHandler() {
        actionHandler?()
        actionSelfHandler?(self)
    }
    
    @discardableResult
    public func onAction(_ handler: @escaping () -> Void) -> Self {
        actionHandler = handler
        return self
    }
    
    @discardableResult
    public func onAction(_ handler: @escaping (UPopUpButton) -> Void) -> Self {
        actionSelfHandler = handler
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func alignment(_ v: NSTextAlignment) -> Self {
        alignment = v
        return self
    }
    
    @discardableResult
    public func baseWritingDirection(_ v: NSWritingDirection) -> Self {
        baseWritingDirection = v
        return self
    }
    
    @discardableResult
    public func usesSingleLineMode(_ v: Bool) -> Self {
        usesSingleLineMode = v
        return self
    }
    
    @discardableResult
    public func allowsExpansionToolTips(_ v: Bool) -> Self {
        allowsExpansionToolTips = v
        return self
    }
    
    @discardableResult
    public func preferredEdge(_ v: NSRectEdge) -> Self {
        preferredEdge = v
        return self
    }
}

extension UPopUpButton: _Titleable {
    var _statedTitle: AnyStringBuilder.Handler? {
        get { nil }
        set {}
    }
    
    func _setTitle(_ v: NSAttributedString?) {
        attributedTitle = .init() // hack to update attributed string with changed paragraph style
        attributedTitle = v ?? .init()
    }
}

extension UPopUpButton: _Enableable {
    func _setEnabled(_ v: Bool) {
        isEnabled = v
    }
}

extension UPopUpButton: _PullsDownable {
    func _setPullsDown(_ v: Bool) {
        pullsDown = v
    }
}

extension UPopUpButton: _ArrowPositionable {
    func _setArrowPosition(_ v: NSPopUpButton.ArrowPosition) {
        (cell as? NSPopUpButtonCell)?.arrowPosition = v
    }
}

extension UPopUpButton: _BezelStyleable {
    func _setBezelStyle(_ v: NSButton.BezelStyle) {
        bezelStyle = v
    }
}

extension UPopUpButton: _MultiClickIgnorable {
    func _setIgnoreMultiClick(_ v: Bool) {
        ignoresMultiClick = v
    }
}

extension UPopUpButton: _Continuousable {
    func _setContinuous(_ v: Bool) {
        isContinuous = v
    }
}

extension UPopUpButton: _FirstResponderRefusable {
    func _setRefuseFirstResponder(_ v: Bool) {
        refusesFirstResponder = v
    }
}

extension UPopUpButton: _Borderedable {
    func _setBordered(_ v: Bool) {
        isBordered = v
    }
}

extension UPopUpButton: _Soundable {
    func _setSound(_ v: NSSound?) {
        sound = v
    }
}

extension UPopUpButton: _Keyable {
    func _setKey(_ v: String) {
        keyEquivalent = v
    }
}

extension UPopUpButton: _KeyMaskable {
    func _setKeyMask(_ v: NSEvent.ModifierFlags) {
        keyEquivalentModifierMask = v
    }
}
#endif
