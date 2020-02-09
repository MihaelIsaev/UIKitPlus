import UIKit

/// aka `UITextView`
open class TextView: UITextView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TextView { self }
    public lazy var properties = Properties<TextView>()
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
    
    fileprivate var stateString: StateStringBuilder.Handler?
    var binding: UIKitPlus.State<String>?
    
    public init (_ text: String = "", textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        _setup()
        self.text = text
    }
    
    public init (_ state: State<String>, textContainer: NSTextContainer? = nil) {
        self.binding = state
        super.init(frame: .zero, textContainer: textContainer)
        _setup()
        text = state.wrappedValue
        state.listen { _,n in self.text = n }
    }
    
    public init (_ attributedStrings: AttributedString..., textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        _setup()
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
    }
    
    public init<V>(_ expressable: ExpressableState<V, String>, textContainer: NSTextContainer? = nil) {
        stateString = expressable.value
        super.init(frame: .zero, textContainer: textContainer)
        _setup()
        text = expressable.value()
        expressable.state.listen { [weak self] _,_ in self?.text = expressable.value() }
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler, textContainer: NSTextContainer? = nil) {
        self.stateString = stateString
        super.init(frame: .zero, textContainer: textContainer)
        _setup()
        self.text = stateString()
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        _setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var _delegate = TextViewDelegate(self)
    
    private func _setup() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        delegate = _delegate
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
    public func text(_ attributedStrings: AttributedString...) -> Self {
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
    public func text<V>(_ expressable: ExpressableState<V, String>) -> Self {
        self.stateString = expressable.value
        text = expressable.value()
        expressable.state.listen { [weak self] _,_ in self?.text = expressable.value() }
        return self
    }
    
    @discardableResult
    public func text(@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) -> Self {
        self.stateString = stateString
        text = stateString()
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
    public func font(v: UIFont?) -> Self {
        self.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    // MARK: Scrolling
    
    @discardableResult
    public func scrolling(_ enabled: Bool) -> Self {
        isScrollEnabled = enabled
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideIndicator(_ indicators: NSLayoutConstraint.Axis...) -> Self {
        if indicators.contains(.horizontal) {
            showsHorizontalScrollIndicator = false
        }
        if indicators.contains(.vertical) {
            showsVerticalScrollIndicator = false
        }
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideAllIndicators() -> Self {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func keyboard(_ keyboard: UIKeyboardType) -> Self {
        keyboardType = keyboard
        return self
    }
    
    @discardableResult
    public func autocapitalization(_ type: UITextAutocapitalizationType) -> Self {
        autocapitalizationType = type
        return self
    }
    
    @discardableResult
    public func autocorrection(_ type: UITextAutocorrectionType) -> Self {
        autocorrectionType = type
        return self
    }
    
    @discardableResult
    public func returnKeyType(_ type: UIReturnKeyType) -> Self {
        returnKeyType = type
        return self
    }
    
    @discardableResult
    public func keyboardAppearance(_ appearance: UIKeyboardAppearance) -> Self {
        keyboardAppearance = appearance
        return self
    }
    
    @discardableResult
    public func content(_ content: TextFieldContentType) -> Self {
        if #available(iOS 10.0, *) {
            if let type = content.type {
                textContentType = type
            }
        }
        return self
    }
        
    @discardableResult
    public func textInsets(_ insets: UIEdgeInsets) -> Self {
        textContainerInset = insets
        return self
    }
    
    @discardableResult
    public func textInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        textInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    // MARK: Cleanup
    
    @discardableResult
    public func cleanup() -> Self {
        text = ""
        didChangeTextHandler?()
        didChangeTextHandlerText?(self)
        return self
    }
    
    // MARK: Input View
    
    @discardableResult
    public func inputView(_ view: UIView) -> Self {
        inputView = view
        return self
    }
    
    @discardableResult
    public func inputView(_ view: (TextView) -> UIView) -> Self {
        inputView(view(self))
    }
    
    @discardableResult
    public func inputAccessoryView(_ view: UIView) -> Self {
        inputAccessoryView = view
        return self
    }
    
    @discardableResult
    public func inputAccessoryView(_ view: (TextView) -> UIView) -> Self {
        inputAccessoryView(view(self))
    }
    
    // MARK: Placeholder
    
    @State var placeholderText: String?
    @State var placeholderColor: UIColor = .lightGray
    @State var placeholderFont: UIFont?
    @State var placeholderAlignment: NSTextAlignment?
    let defaultPlaceholderFont: UIFont = UIFont.systemFont(ofSize: 14)
    var generatedPlaceholderString: NSAttributedString?
    
    @discardableResult
    public func placeholder(_ value: String) -> Self {
        placeholderText = value
        if text.count == 0 && attributedText.string.count == 0 {
            attributedText = _generatePlaceholderAttributedString(with: value)
        }
        return self
    }
    
    func _generatePlaceholderAttributedString(with text: String) -> NSAttributedString {
        let str = AttrStr(text).foreground(placeholderColor).font(v: font ?? defaultPlaceholderFont).attributedString
        generatedPlaceholderString = str
        return str
    }
    
    @discardableResult
    public func placeholderColor(_ color: UIColor) -> Self {
        placeholderColor = color
        return self
    }
    
    @discardableResult
    public func placeholderColor(_ number: Int) -> Self {
        placeholderColor = number.color
        return self
    }
    
    @discardableResult
    public func placeholderFont(v: UIFont?) -> Self {
        self.placeholderFont = v
        return self
    }
    
    @discardableResult
    public func placeholderFont(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        placeholderFont(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func placeholderAlignment(_ alignment: NSTextAlignment) -> Self {
        placeholderAlignment = alignment
        return self
    }
    
    // MARK: - Delegate Replication
    
    public typealias SimpleHandler = () -> Void
    public typealias SimpleHandlerText = (TextView) -> Void
    public typealias BoolHandler = () -> Bool
    public typealias BoolHandlerText = (TextView) -> Bool
    public typealias BoolHandlerTextRangeString = (TextView, NSRange, String) -> Bool
    public typealias BoolHandlerRangeString = (NSRange, String) -> Bool
    public typealias BoolHandlerTextURLRange = (TextView, URL, NSRange) -> Bool
    public typealias BoolHandlerTextURLRangeInteraction = (TextView, URL, NSRange, TextItemInteraction) -> Bool
    public typealias BoolHandlerTextTextAttachmentRange = (TextView, NSTextAttachment, NSRange) -> Bool
    public typealias BoolHandlerTextTextAttachmentRangeInteraction = (TextView, NSTextAttachment, NSRange, TextItemInteraction) -> Bool
    
    // MARK: textViewShouldBeginEditing
    
    var shouldBeginEditingHandler: BoolHandler?
    var shouldBeginEditingHandlerText: BoolHandlerText?
    
    @discardableResult
    public func onShouldBeginEditing(_ handler: @escaping BoolHandler) -> Self {
        shouldBeginEditingHandlerText = nil
        shouldBeginEditingHandler = handler
        return self
    }
    
    @discardableResult
    public func onShouldBeginEditing(_ handler: @escaping BoolHandlerText) -> Self {
        shouldBeginEditingHandler = nil
        shouldBeginEditingHandlerText = handler
        return self
    }
    
    // MARK: textViewShouldEndEditing
    
    var shouldEndEditingHandler: BoolHandler?
    var shouldEndEditingHandlerText: BoolHandlerText?
    
    @discardableResult
    public func onShouldEndEditing(_ handler: @escaping BoolHandler) -> Self {
        shouldEndEditingHandler = handler
        shouldEndEditingHandlerText = nil
        return self
    }
    
    @discardableResult
    public func onShouldEndEditing(_ handler: @escaping BoolHandlerText) -> Self {
        shouldEndEditingHandler = nil
        shouldEndEditingHandlerText = handler
        return self
    }
    
    // MARK: textViewDidBeginEditing
    
    var didBeginEditingHandler: SimpleHandler?
    var didBeginEditingHandlerText: SimpleHandlerText?
    
    @discardableResult
    public func onDidBeginEditing(_ handler: @escaping SimpleHandler) -> Self {
        didBeginEditingHandler = handler
        return self
    }
    
    @discardableResult
    public func onDidBeginEditing(_ handler: @escaping SimpleHandlerText) -> Self {
        didBeginEditingHandlerText = handler
        return self
    }
    
    // MARK: textViewDidEndEditing
    
    var didEndEditingHandler: SimpleHandler?
    var didEndEditingHandlerText: SimpleHandlerText?
    
    @discardableResult
    public func onDidEndEditing(_ handler: @escaping SimpleHandler) -> Self {
        didBeginEditingHandler = handler
        return self
    }
    
    @discardableResult
    public func onDidEndEditing(_ handler: @escaping SimpleHandlerText) -> Self {
        didBeginEditingHandlerText = handler
        return self
    }
    
    // MARK: shouldChangeTextInRange
    
    var shouldChangeTextHandler: BoolHandler?
    var shouldChangeTextHandlerText: BoolHandlerText?
    var shouldChangeTextHandlerTextRangeString: BoolHandlerTextRangeString?
    var shouldChangeTextHandlerRangeString: BoolHandlerRangeString?
    
    @discardableResult
    public func onShouldChangeText(_ handler: @escaping BoolHandler) -> Self {
        shouldChangeTextHandler = handler
        shouldChangeTextHandlerText = nil
        shouldChangeTextHandlerTextRangeString = nil
        shouldChangeTextHandlerRangeString = nil
        return self
    }
    
    @discardableResult
    public func onShouldChangeText(_ handler: @escaping BoolHandlerText) -> Self {
        shouldChangeTextHandler = nil
        shouldChangeTextHandlerText = handler
        shouldChangeTextHandlerTextRangeString = nil
        shouldChangeTextHandlerRangeString = nil
        return self
    }
    
    @discardableResult
    public func onShouldChangeText(_ handler: @escaping BoolHandlerTextRangeString) -> Self {
        shouldChangeTextHandler = nil
        shouldChangeTextHandlerText = nil
        shouldChangeTextHandlerTextRangeString = handler
        shouldChangeTextHandlerRangeString = nil
        return self
    }
    
    @discardableResult
    public func onShouldChangeText(_ handler: @escaping BoolHandlerRangeString) -> Self {
        shouldChangeTextHandler = nil
        shouldChangeTextHandlerText = nil
        shouldChangeTextHandlerTextRangeString = nil
        shouldChangeTextHandlerRangeString = handler
        return self
    }
    
    // MARK: textViewDidChange
    
    var didChangeTextHandler: SimpleHandler?
    var didChangeTextHandlerText: SimpleHandlerText?
    
    @discardableResult
    public func onTextDidChange(_ handler: @escaping SimpleHandler) -> Self {
        didChangeTextHandler = handler
        return self
    }
    
    @discardableResult
    public func onTextDidChange(_ handler: @escaping SimpleHandlerText) -> Self {
        didChangeTextHandlerText = handler
        return self
    }
    
    // MARK: textViewDidChangeSelection
    
    var didChangeSelectionHandler: SimpleHandler?
    var didChangeSelectionHandlerText: SimpleHandlerText?
    
    @discardableResult
    public func onDidChangeSelection(_ handler: @escaping SimpleHandler) -> Self {
        didChangeSelectionHandler = handler
        return self
    }
    
    @discardableResult
    public func onDidChangeSelection(_ handler: @escaping SimpleHandlerText) -> Self {
        didChangeSelectionHandlerText = handler
        return self
    }
    
    // MARK: shouldInteractWithURLInteraction
    
    var shouldInteractWithURLHandler: BoolHandler?
    var shouldInteractWithURLHandlerText: BoolHandlerText?
    var shouldInteractWithURLHandlerURLRange: BoolHandlerTextURLRange?
    var shouldInteractWithURLHandlerURLRangeInteraction: BoolHandlerTextURLRangeInteraction?
    
    @discardableResult
    public func shouldInteractWithURL(_ handler: @escaping BoolHandler) -> Self {
        shouldInteractWithURLHandler = handler
        shouldInteractWithURLHandlerText = nil
        shouldInteractWithURLHandlerURLRange = nil
        shouldInteractWithURLHandlerURLRangeInteraction = nil
        return self
    }
    
    @discardableResult
    public func shouldInteractWithURL(_ handler: @escaping BoolHandlerText) -> Self {
        shouldInteractWithURLHandler = nil
        shouldInteractWithURLHandlerText = handler
        shouldInteractWithURLHandlerURLRange = nil
        shouldInteractWithURLHandlerURLRangeInteraction = nil
        return self
    }
    
    @discardableResult
    public func shouldInteractWithURL(_ handler: @escaping BoolHandlerTextURLRange) -> Self {
        shouldInteractWithURLHandler = nil
        shouldInteractWithURLHandlerText = nil
        shouldInteractWithURLHandlerURLRange = handler
        shouldInteractWithURLHandlerURLRangeInteraction = nil
        return self
    }
    
    @discardableResult
    public func shouldInteractWithURL(_ handler: @escaping BoolHandlerTextURLRangeInteraction) -> Self {
        shouldInteractWithURLHandler = nil
        shouldInteractWithURLHandlerText = nil
        shouldInteractWithURLHandlerURLRange = nil
        shouldInteractWithURLHandlerURLRangeInteraction = handler
        return self
    }
    
    // MARK: shouldInteractWithTextAttachmentInteraction
    
    var shouldInteractWithTextAttachmentHandler: BoolHandler?
    var shouldInteractWithTextAttachmentHandlerText: BoolHandlerText?
    var shouldInteractWithTextAttachmentHandlerRange: BoolHandlerTextTextAttachmentRange?
    var shouldInteractWithTextAttachmentHandlerRangeInteraction: BoolHandlerTextTextAttachmentRangeInteraction?
    
    @discardableResult
    public func shouldInteractWithTextAttachment(_ handler: @escaping BoolHandler) -> Self {
        shouldInteractWithTextAttachmentHandler = handler
        shouldInteractWithTextAttachmentHandlerText = nil
        shouldInteractWithTextAttachmentHandlerRange = nil
        shouldInteractWithTextAttachmentHandlerRangeInteraction = nil
        return self
    }
    
    @discardableResult
    public func shouldInteractWithTextAttachment(_ handler: @escaping BoolHandlerText) -> Self {
        shouldInteractWithTextAttachmentHandler = nil
        shouldInteractWithTextAttachmentHandlerText = handler
        shouldInteractWithTextAttachmentHandlerRange = nil
        shouldInteractWithTextAttachmentHandlerRangeInteraction = nil
        return self
    }
    
    @discardableResult
    public func shouldInteractWithTextAttachment(_ handler: @escaping BoolHandlerTextTextAttachmentRange) -> Self {
        shouldInteractWithTextAttachmentHandler = nil
        shouldInteractWithTextAttachmentHandlerText = nil
        shouldInteractWithTextAttachmentHandlerRange = handler
        shouldInteractWithTextAttachmentHandlerRangeInteraction = nil
        return self
    }
    
    @discardableResult
    public func shouldInteractWithTextAttachment(_ handler: @escaping BoolHandlerTextTextAttachmentRangeInteraction) -> Self {
        shouldInteractWithTextAttachmentHandler = nil
        shouldInteractWithTextAttachmentHandlerText = nil
        shouldInteractWithTextAttachmentHandlerRange = nil
        shouldInteractWithTextAttachmentHandlerRangeInteraction = handler
        return self
    }
}

extension TextView: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = stateString {
            text = stateString()
        }
    }
}
