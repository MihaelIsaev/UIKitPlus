import UIKit

public typealias UTextView = TextView
/// aka `UITextView`
open class TextView: UITextView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TextView { self }
    public lazy var properties = Properties<TextView>()
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
    
    public init (_ text: String, textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        self.text(text)
        _setup()
    }
    
    public init (_ localized: LocalizedString..., textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        self.text(String(localized))
        _setup()
    }
    
    public init (_ localized: [LocalizedString], textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        self.text(String(localized))
        _setup()
    }
    
    public init (_ state: UState<String>, textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        _properties.textBinding = state
        text(state)
        _setup()
    }
    
    public init (_ attributedStrings: AttributedString..., textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        attributedText(attributedStrings.joined())
        _setup()
    }
    
    public init<V>(_ expressable: ExpressableState<V, String>, textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        let state = expressable.unwrap()
        _properties.textBinding = state
        text(state)
        _setup()
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler, textContainer: NSTextContainer? = nil) {
        super.init(frame: .zero, textContainer: textContainer)
        text(stateString())
        _setup()
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
        textContainer.lineFragmentPadding = 0
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
    public func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
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
        if let stateString = _properties.stateString {
            text = stateString()
        }
    }
}

extension TextView: _Fontable {
    func _setFont(_ v: UIFont?) {
        font = v
    }
}

extension TextView: _TextBindable {
    func _setTextBind(_ binding: UState<String>?) {
        _properties.textBinding = binding
    }
}

extension TextView: _Textable {
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

extension TextView: _Typeable {
    func _setTypingInterval(_ v: TimeInterval) {
        _properties.typingInterval = v
    }
    
    func _observeTypingState(_ v: UIKitPlus.UState<Bool>) {
        _properties.isTypingState.listen {
            guard v.wrappedValue != $0 else { return }
            v.wrappedValue = $0
        }
        if v.wrappedValue != _properties.isTyping {
            v.wrappedValue = _properties.isTyping
        }
    }
}

extension TextView: _Colorable {
    var _colorState: UIKitPlus.UState<UIColor> { properties.textColorState }
    
    func _setColor(_ v: UIColor?) {
        textColor = v
        properties.textColor = v ?? .clear
    }
}

extension TextView: _TextAligmentable {
    func _setTextAlignment(v: NSTextAlignment) {
        textAlignment = v
    }
}

extension TextView: _Placeholderable {
    func _setPlaceholder(_ v: String) {
        _properties.placeholderText = v
        if text.count == 0 && attributedText.string.count == 0 {
            attributedText = _generatePlaceholderAttributedString(with: v)
        }
    }

    func _setPlaceholder(_ v: AttrStr?) {
        attributedText = v?.attributedString
        _properties.placeholderText = attributedText?.string ?? ""
        _properties.placeholderAttrText = v?.attributedString
    }
    
    func _generatePlaceholderAttributedString(with text: String) -> NSAttributedString {
        guard let placeholderAttrText = _properties.placeholderAttrText else {
            let str = AttrStr(text).foreground(.lightGray).font(v: font ?? .systemFont(ofSize: 14)).attributedString
            _properties.generatedPlaceholderString = str
            return str
        }
        return placeholderAttrText
    }
}


extension TextView: _Keyboardable {
    func _setKeyboardType(_ v: UIKeyboardType) {
        keyboardType = v
    }
    
    func _setReturnKeyType(_ v: UIReturnKeyType) {
        returnKeyType = v
    }
    
    func _setKeyboardAppearance(_ v: UIKeyboardAppearance) {
        keyboardAppearance = v
    }
    
    func _setInputView(_ v: UIView?) {
        inputView = v
    }
    
    func _setInputAccessoryView(_ v: UIView?) {
        inputAccessoryView = v
    }
    
    @discardableResult
    public func inputView(_ view: (TextView) -> UIView) -> Self {
        inputView(view(self))
    }
    
    @discardableResult
    public func inputAccessoryView(_ view: (TextView) -> UIView) -> Self {
        inputAccessoryView(view(self))
    }
}

extension TextView: _TextAutocapitalizationable {
    func _setTextAutocapitalizationType(_ v: UITextAutocapitalizationType) {
        autocapitalizationType = v
    }
}

extension TextView: _TextAutocorrectionable {
    func _setTextAutocorrectionType(_ v: UITextAutocorrectionType) {
        autocorrectionType = v
    }
}

extension TextView: _Cleanupable {
    func _cleanup() {
        text = ""
        didChangeTextHandler?()
        didChangeTextHandlerText?(self)
    }
}

extension TextView: _Scrollable {
    func _setScrollingEnabled(_ v: Bool) {
        isScrollEnabled = v
    }
    
    func _setVisibleHScrollIndicator(_ v: Bool) {
        showsHorizontalScrollIndicator = v
    }
    
    func _setVisibleVScrollIndicator(_ v: Bool) {
        showsVerticalScrollIndicator = v
    }
}

extension TextView: _Enableable {
    func _setEnabled(_ v: Bool) {
        self.isEditable = v
    }
}
