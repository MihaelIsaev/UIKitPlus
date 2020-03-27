import UIKit

/// aka `UILabel`
@available(*, deprecated, renamed: "Text")
public typealias Label = Text

public typealias UText = Text
/// aka `UILabel`
open class Text: UILabel, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Text { self }
    public lazy var properties = Properties<Text>()
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
    
    public init (_ text: String) {
        super.init(frame: .zero)
        _setup()
        self.text(text)
    }
    
    public init (_ state: State<String>) {
        super.init(frame: .zero)
        _setup()
        text(state)
    }
    
    public init (attributed state: State<[AttrStr]>) {
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
    var _colorState: State<UIColor> { properties.textColorState }
    
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
