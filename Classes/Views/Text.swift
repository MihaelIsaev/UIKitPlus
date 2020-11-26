import UIKit

public typealias Label = Text
public typealias UText = Text

/// aka `UILabel`
open class Text: UILabel, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Text { self }
    public lazy var properties = Properties<Text>()
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
    
    public init (_ text: String) {
        super.init(frame: .zero)
        _setup()
        self.text(text)
    }
    
    public init (_ localized: LocalizedString...) {
        super.init(frame: .zero)
        _setup()
        self.text(String(localized))
    }
    
    public init (_ localized: [LocalizedString]) {
        super.init(frame: .zero)
        _setup()
        self.text(String(localized))
    }
    
    public init (_ state: UState<String>) {
        super.init(frame: .zero)
        _setup()
        text(state)
    }
    
    public init (attributed state: UState<[AttrStr]>) {
        super.init(frame: .zero)
        _setup()
        attributedText(state)
    }
    
    public init (attributed attributedStrings: AttrStr...) {
        super.init(frame: .zero)
        _setup()
        attributedText(attributedStrings)
    }
    
    public init (attributed attributedStrings: [AttrStr]) {
        super.init(frame: .zero)
        _setup()
        attributedText(attributedStrings)
    }
    
    public init<V>(_ expressable: ExpressableState<V, String>) {
        super.init(frame: .zero)
        _setup()
        text(expressable)
    }
    
    public init<V>(attributed expressable: ExpressableState<V, [AttrStr]>) {
        super.init(frame: .zero)
        _setup()
        attributedText(expressable)
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) {
        super.init(frame: .zero)
        _setup()
        text(stateString())
    }
    
    public init (@StateStringBuilder stateString: @escaping StateAttrStringBuilder.Handler) {
        super.init(frame: .zero)
        _setup()
        attributedText(stateString())
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
}

extension Text: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = _properties.stateString {
            text(stateString())
        } else if let stateAttrString = _properties.stateAttrString {
            attributedText(stateAttrString())
        }
    }
}

extension Text: _Fontable {
    func _setFont(_ v: UIFont?) {
        font = v
    }
}

extension Text: _Textable {
    var _stateString: StateStringBuilder.Handler? {
        get { _properties.stateString }
        set { _properties.stateString = newValue }
    }
    
    var _stateAttrString: StateAttrStringBuilder.Handler? {
        get { _properties.stateAttrString }
        set { _properties.stateAttrString = newValue }
    }
    
    var _textChangeTransition: UIView.AnimationOptions? {
        get { _properties.textChangeTransition }
        set { _properties.textChangeTransition = newValue }
    }
    
    func _setText(_ v: String?) {
        text = v
    }
    
    func _setText(_ v: NSMutableAttributedString?) {
        attributedText = v
    }
}

extension Text: _ViewTransitionable {
    var _transitionableView: UIView { self }
}

extension Text: _Colorable {
    var _colorState: UState<UIColor> { properties.textColorState }
    
    func _setColor(_ v: UIColor?) {
        textColor = v
        properties.textColor = v ?? .clear
    }
}

extension Text: _TextAligmentable {
    func _setTextAlignment(v: NSTextAlignment) {
        textAlignment = v
    }
}

extension Text: _TextLineable {
    func _setNumbelOfLines(_ v: Int) {
        numberOfLines = v
    }
}

extension Text: _TextLineBreakModeable {
    func _setLineBreakMode(_ v: NSLineBreakMode) {
        lineBreakMode = v
    }
}

extension Text: _TextAdjustsFontSizeable {
    func _setAdjustsFontSizeToFitWidth(_ v: Bool) {
        adjustsFontSizeToFitWidth = v
    }
}

extension Text: _TextScaleable {
    func _setMinimumScaleFactor(_ v: CGFloat) {
        minimumScaleFactor = v
    }
}
