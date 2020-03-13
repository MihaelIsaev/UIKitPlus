import UIKit

/// aka `UILabel`
@available(*, deprecated, renamed: "Text")
public typealias Label = Text

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
    
    fileprivate var stateString: StateStringBuilder.Handler?
    fileprivate var stateAttrString: StateAttrStringBuilder.Handler?
    private var binding: UIKitPlus.State<String>?
    private var attributedBinding: UIKitPlus.State<[AttributedString]>?
    
    public init (_ text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = text
    }
    
    public init (_ state: State<String>) {
        self.binding = state
        super.init(frame: .zero)
        _setup()
        text = state.wrappedValue
        state.listen { _,n in self.text = n }
    }
    
    public init (attributed state: State<[AttributedString]>) {
        self.attributedBinding = state
        super.init(frame: .zero)
        _setup()
        _applyAttributedStrings(state.wrappedValue)
        state.listen { self._applyAttributedStrings($0) }
    }
    
    public init (attributed attributedStrings: AttributedString...) {
        super.init(frame: .zero)
        _setup()
        _applyAttributedStrings(attributedStrings)
    }
    
    public init<V>(_ expressable: ExpressableState<V, String>) {
        stateString = expressable.value
        super.init(frame: .zero)
        _setup()
        text = expressable.value()
        expressable.state.listen { [weak self] _,_ in self?.text = expressable.value() }
    }
    
    public init<V>(attributed expressable: ExpressableState<V, [AttributedString]>) {
        self.stateAttrString = { expressable.value().joined() }
        self.attributedBinding = expressable.unwrap()
        super.init(frame: .zero)
        _setup()
        _applyAttributedStrings(expressable.value())
        expressable.state.listen { [weak self] _,_ in self?.self._applyAttributedStrings(expressable.value()) }
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) {
        self.stateString = stateString
        super.init(frame: .zero)
        _setup()
        self.text = stateString()
    }
    
    public init (@StateStringBuilder stateString: @escaping StateAttrStringBuilder.Handler) {
        self.stateAttrString = stateString
        super.init(frame: .zero)
        _setup()
        _applyAttributedStrings([stateString()])
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
    
    func _applyAttributedStrings(_ attributedStrings: [AttributedString]) {
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func attributedText(_ attributedStrings: AttributedString...) -> Self {
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
        return self
    }
    
    @discardableResult
    public func text(_ state: State<String>) -> Self {
        text = state.wrappedValue
        state.listen { _,n in self.text = n }
        return self
    }
    
    @discardableResult
    public func attributedText(_ state: State<[AttributedString]>) {
        self.attributedBinding = state
        _applyAttributedStrings(state.wrappedValue)
        state.listen { self._applyAttributedStrings($0) }
    }
    
    @discardableResult
    public func text<V>(_ expressable: ExpressableState<V, String>) -> Self {
        self.stateString = expressable.value
        text = expressable.value()
        expressable.state.listen { [weak self] _,_ in self?.text = expressable.value() }
        return self
    }
    
    @discardableResult
    public func attributedText<V>(_ expressable: ExpressableState<V, [AttributedString]>) -> Self {
        self.stateAttrString = { expressable.value().joined() }
        self.attributedBinding = expressable.unwrap()
        _applyAttributedStrings(expressable.value())
        expressable.state.listen { [weak self] _,_ in self?.self._applyAttributedStrings(expressable.value()) }
        return self
    }
    
    @discardableResult
    public func text(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self {
        self.stateString = stateString
        text = stateString()
        return self
    }
    
    @discardableResult
    public func attributedText(@StateStringBuilder stateString: @escaping StateAttrStringBuilder.Handler) -> Self {
        self.stateAttrString = stateString
        _applyAttributedStrings([stateString()])
        return self
    }
    
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    public func color(_ number: Int) -> Self {
        textColor = number.color
        return self
    }
    
    public var colorState: State<UIColor> { properties.$background }
    
    @discardableResult
    public func color(_ color: State<UIColor>) -> Self {
        declarativeView.textColor = color.wrappedValue
        properties.textColor = color.wrappedValue
        color.listen { [weak self] old, new in
            self?.declarativeView.textColor = new
            self?.properties.textColor = new
        }
        return self
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        declarativeView.textColor = expressable.value()
        properties.textColor = expressable.value()
        expressable.state.listen { [weak self] old, new in
            self?.declarativeView.textColor = expressable.value()
            self?.properties.textColor = expressable.value()
        }
        return self
    }
    
    @discardableResult
    public func minimumScaleFactor(_ value: CGFloat) -> Self {
        self.minimumScaleFactor = value
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool = true) -> Self {
        self.adjustsFontSizeToFitWidth = value
        return self
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func lines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    @discardableResult
    public func multiline() -> Self {
        numberOfLines = 0
        return self
    }
}

extension Text: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = stateString {
            text = stateString()
        } else if let stateAttrString = stateAttrString {
            attributedText = stateAttrString().attributedString
        }
    }
}

extension Text: _Fontable {
    func _setFont(_ v: UIFont?) {
        font = v
    }
}
