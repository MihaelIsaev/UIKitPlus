#if os(macOS)
import Foundation
import AppKit

public typealias UTextField = TextField
open class TextField: NSTextField, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TextField { self }
    public typealias P = Properties<TextField>
    public lazy var properties = P()
    lazy var _properties = PropertiesInternal()
    fileprivate lazy var _formatter = _Formatter(self)
    
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
    
    fileprivate weak var outsideDelegate: TextFieldDelegate?
    
    public init (_ string: AnyString...) {
        super.init(frame: .zero)
        _setup()
        text(string)
    }
    
    public init (_ strings: [AnyString]) {
        super.init(frame: .zero)
        _setup()
        text(strings)
    }
    
    public init (_ localized: LocalizedString...) {
        super.init(frame: .zero)
        _setup()
        text(localized)
    }
    
    public init (_ localized: [LocalizedString]) {
        super.init(frame: .zero)
        _setup()
        text(localized)
    }
    
    public init<A: AnyString>(_ state: UIKitPlus.State<A>) {
        super.init(frame: .zero)
        _setup()
        text(state)
    }
    
    public init<V, A: AnyString>(_ expressable: ExpressableState<V, A>) {
        super.init(frame: .zero)
        _setup()
        text(expressable)
    }
    
    public init (@AnyStringBuilder stateString: @escaping AnyStringBuilder.Handler) {
        super.init(frame: .zero)
        _setup()
        text(stateString: stateString)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        movedToSuperview()
    }
    
    fileprivate lazy var _innerDelegate = _InnerDelegate(self)
    
    open override var stringValue: String {
        get { attributedStringValue.string }
        set { attributedStringValue = .init(string: newValue) }
    }
    
    func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = _innerDelegate
        formatter = _formatter
    }
    
    @discardableResult
    public func delegate(_ delegate: TextFieldDelegate?) -> Self {
        self.outsideDelegate = delegate
        return self
    }
    
    // MARK: Delegate Closures
    
    @discardableResult
    public func shouldBeginEditing(_ closure: @escaping P.BoolClosure) -> Self {
        properties._shouldBeginEditing = closure
        return self
    }
    
    @discardableResult
    public func didBeginEditing(_ closure: @escaping P.VoidClosure) -> Self {
        properties._didBeginEditing.append(closure)
        return self
    }
    
    @discardableResult
    public func shouldEndEditing(_ closure: @escaping P.BoolClosure) -> Self {
        properties._shouldEndEditing = closure
        return self
    }
    
    @discardableResult
    public func didEndEditing(_ closure: @escaping P.VoidClosure) -> Self {
        properties._didEndEditing.append(closure)
        return self
    }
    
    /// An alternative to `shouldChangeCharacters`
    /// It will disable `shouldChangeCharacters`
    ///
    /// Use this handler with formatters like `AnyFormatKit`
    ///
    /// ```swift
    /// import AnyFormatKit
    ///
    /// fileprivate let phoneFormatter = DefaultTextInputFormatter(textPattern: "(###) ###-####")
    ///
    /// extension TextField {
    ///     static var phone: TextField {
    ///         return TextField()
    ///             .content(.telephoneNumber)
    ///             .autocapitalization(.none)
    ///             .autocorrection(.no)
    ///             .keyboard(.phonePad)
    ///             .font(.articoRegular, 15)
    ///             .placeholder("(555) 123-4567".foreground(.darkGrey).font(.helveticaNeueRegular, 15))
    ///             .color(.blackHole)
    ///             .height(18)
    ///             .formatCharacters { textField, range, text in
    ///                 let result = phoneFormatter.formatInput(currentText: textField.stringValue, range: range, replacementString: text)
    ///                 textField.stringValue = result.formattedText
    ///                 textField.currentEditor()?.selectedRange = NSRange(location: result.caretBeginOffset, length: 0)
    ///             }
    ///     }
    /// }
    /// ```
    @discardableResult
    public func formatCharacters(_ closure: @escaping P.FormatCharactersClosure) -> Self {
        properties._shouldFormatCharacters = closure
        return self
    }
    
    @discardableResult
    public func shouldChangeCharacters(_ closure: @escaping P.ChangeCharactersClosure) -> Self {
        properties._shouldChangeCharacters = closure
        return self
    }
    
    @discardableResult
    public func shouldClear(_ closure: @escaping P.BoolClosure) -> Self {
        properties._shouldClear = closure
        return self
    }
    
//    @discardableResult
//    public func shouldReturn(_ closure: @escaping () -> Void) -> Self {
//        properties._shouldReturnVoid = closure
//        return self
//    }
//
//    @discardableResult
//    public func shouldReturn(_ closure: @escaping P.BoolClosure) -> Self {
//        properties._shouldReturn = closure
//        return self
//    }
    
//    @discardableResult
//    public func shouldReturnToNextResponder() -> Self {
//        properties._shouldReturnVoid = {
//            self.focusToNextResponderOrResign()
//        }
//        return self
//    }

    @discardableResult
    public func formater(_ v: Formatter) -> Self {
        formatter = v
        return self
    }
    
    @discardableResult
    public func editingDidBegin(_ closure: @escaping P.VoidClosure) -> Self {
        properties._editingDidBegin.append(closure)
        return self
    }
    
    @discardableResult
    public func editingChanged(_ closure: @escaping P.VoidClosure) -> Self {
        properties._editingChanged.append(closure)
        return self
    }
    
    @discardableResult
    public func editingDidEnd(_ closure: @escaping P.VoidClosure) -> Self {
        properties._editingDidEnd.append(closure)
        return self
    }
    
    @discardableResult
    public func onAction(_ closure: @escaping P.EmptyVoidClosure) -> Self {
        properties._textFieldEmptyAction.append(closure)
        return self
    }
    
    @discardableResult
    public func onAction(_ closure: @escaping P.VoidClosure) -> Self {
        properties._textFieldAction.append(closure)
        return self
    }
    
    func _setBackgroundColor(_ v: NSColor?) {
        guard v != .clear else {
            (cell as? NSTextFieldCell)?.drawsBackground = false
            return
        }
        guard let v = v else {
            (cell as? NSTextFieldCell)?.drawsBackground = false
            return
        }
        (cell as? NSTextFieldCell)?.drawsBackground = true
        (cell as? NSTextFieldCell)?.backgroundColor = v
    }
    
//    public func `return`() {
//        _ = _innerDelegate.textFieldShouldReturn(self)
//    }
}

fileprivate class _InnerDelegate: NSObject, NSTextFieldDelegate {
    let parent: TextField
    
    init (_ textField: TextField) {
        parent = textField
        super.init()
        parent.target = self
        parent.action = #selector(action)
        
    }
    
    @objc func action() {
        parent.properties._textFieldAction.forEach { $0(self.parent) }
        parent.properties._textFieldEmptyAction.forEach { $0() }
    }
    
    @objc func editingDidBegin() {
        parent.properties._editingDidBegin.forEach { $0(self.parent) }
    }
    
    @objc private func invalidateTimer() {
        parent._properties.isTyping = false
    }
    
    @objc func editingChanged() {
        parent._properties.typingTimer?.invalidate()
        parent._properties.typingTimer = Timer.scheduledTimer(timeInterval: parent._properties.typingInterval, target: self, selector: #selector(invalidateTimer), userInfo: nil, repeats: false)
        parent._properties.isTyping = true
        parent.properties._editingChanged.forEach { $0(self.parent) }
        parent._properties.textChangeListeners.forEach {
            $0(parent.attributedStringValue)
        }
    }
    
    @objc func editingDidEnd() {
        parent.properties._editingDidEnd.forEach { $0(self.parent) }
    }
    
    // MARK: NSTextFieldDelegate
    
//    public func textField(_ textField: NSTextField, textView: NSTextView, candidatesForSelectedRange selectedRange: NSRange) -> [Any]? {
//
//    }
//
//    public func textField(_ textField: NSTextField, textView: NSTextView, candidates: [NSTextCheckingResult], forSelectedRange selectedRange: NSRange) -> [NSTextCheckingResult] {
//
//    }
//
//    public func textField(_ textField: NSTextField, textView: NSTextView, shouldSelectCandidateAt index: Int) -> Bool {
//
//    }
    
    // MARK: NSControlTextEditingDelegate
    
    public func controlTextDidBeginEditing(_ obj: Notification) {
        editingDidBegin()
        parent.outsideDelegate?.textFieldDidBeginEditing?(parent)
        parent.properties._didBeginEditing.forEach { $0(self.parent) }
    }

    public func controlTextDidEndEditing(_ obj: Notification) {
        editingDidEnd()
        parent.outsideDelegate?.textFieldDidEndEditing?(parent)
        parent.properties._didEndEditing.forEach { $0(self.parent) }
    }

    public func controlTextDidChange(_ obj: Notification) {
        editingChanged()
    }
    
    public func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        parent.outsideDelegate?.textFieldShouldBeginEditing?(parent) ?? parent.properties._shouldBeginEditing(parent)
    }

    public func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        parent.outsideDelegate?.textFieldShouldEndEditing?(parent) ?? parent.properties._shouldEndEditing(parent)
    }
}

extension TextField: _Editableable {
    func _setEditable(_ v: Bool) {
        isEditable = v
    }
}

extension TextField: _TextAttributesEditingAllowable {
    func _setAllowEditingTextAttributes(_ v: Bool) {
        allowsEditingTextAttributes = v
    }
}

extension TextField: _Bezeledable {
    func _setBezeled(_ v: Bool) {
        isBezeled = v
    }
}

extension TextField: _FocusRingTypeable {
    func _setFocusRingType(_ v: NSFocusRingType) {
        focusRingType = v
    }
}

extension TextField: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let statedText = _properties.statedText {
            text(statedText())
        }
    }
}

extension TextField: _Enableable {
    func _setEnabled(_ v: Bool) {
        isEnabled = v
    }
}

extension TextField: _Fontable {
    func _setFont(_ v: UFont?) {
        font = v
    }
}

extension TextField: _Cleanupable {
    func _cleanup() {
        attributedStringValue = .init()
        _innerDelegate.controlTextDidChange(.init(name: Notification.Name.init("")))
    }
}

extension TextField: _Colorable {
    var _colorState: State<UColor> { properties.textColorState }

    func _setColor(_ v: NSColor?) {
        let str = NSMutableAttributedString(attributedString: attributedStringValue)
        if let v = v {
            str.addAttribute(.foregroundColor, value: v, range: NSRange(location: 0, length: str.length))
        } else {
            str.removeAttribute(.foregroundColor, range: NSRange(location: 0, length: str.length))
        }
        attributedStringValue = str.attrString
    }
}

extension TextField: _TextAligmentable {
    func _setTextAlignment(v: NSTextAlignment) {
        let p = NSMutableParagraphStyle()
        p.alignment = v
        let str = NSMutableAttributedString(attributedString: attributedStringValue)
        str.addAttribute(.paragraphStyle, value: p, range: NSRange(location: 0, length: str.length))
        attributedStringValue = str.attrString
        alignment = v
    }
}

extension TextField: _TextBindable {
    func _setTextBind<A: AnyString>(_ binding: UIKitPlus.State<A>?) {
        _properties.textChangeListeners.append({ new in
            binding?.wrappedValue = A.make(new)
        })
    }
}

extension TextField: _Textable {
    var _statedText: AnyStringBuilder.Handler? {
        get { _properties.statedText }
        set { _properties.statedText = newValue }
    }
    
    func _setText(_ v: NSAttributedString?) {
        attributedStringValue = v ?? .init()
    }
}

extension TextField: _Typeable {
    func _setTypingInterval(_ v: TimeInterval) {
        _properties.typingInterval = v
    }
    
    func _observeTypingState(_ v: UIKitPlus.State<Bool>) {
        _properties.isTypingState.listen {
            guard v.wrappedValue != $0 else { return }
            v.wrappedValue = $0
        }
        if v.wrappedValue != _properties.isTyping {
            v.wrappedValue = _properties.isTyping
        }
    }
}

extension TextField: _Placeholderable {
    var _statedPlaceholder: AnyStringBuilder.Handler? {
        get { _properties.statedPlaceholder }
        set { _properties.statedPlaceholder = newValue }
    }

    func _setPlaceholder(_ v: NSAttributedString?) {
        (cell as? NSTextFieldCell)?.placeholderAttributedString = v
        _properties.placeholderAttrText = v
    }
}

//extension TextField: _TextAutocapitalizationable {
//    func _setTextAutocapitalizationType(_ v: UITextAutocapitalizationType) {
//        autocapitalizationType = v
//    }
//}
//
//extension TextField: _TextAutocorrectionable {
//    func _setTextAutocorrectionType(_ v: UITextAutocorrectionType) {
//        autocorrectionType = v
//    }
//}
//
//extension TextField: _TextFieldContentTypeable {
//    func _setTextFieldContentType(v: TextFieldContentType) {
//        if #available(iOS 10.0, *) {
//            if let type = v.type {
//                textContentType = type
//            }
//        }
//    }
//}

fileprivate class _Formatter<TF>: NumberFormatter where TF: TextField {
    let tf: TF
    
    init(_ tf: TF) {
        self.tf = tf
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as NSString
        return true
    }
    
    override func string(for obj: Any?) -> String? {
        obj as? String
    }
    
    override func attributedString(for obj: Any, withDefaultAttributes attrs: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString? {
        obj as? NSAttributedString
    }
    
    override func isPartialStringValid(_ partialStringPtr: AutoreleasingUnsafeMutablePointer<NSString>, proposedSelectedRange proposedSelRangePtr: NSRangePointer?, originalString origString: String, originalSelectedRange origSelRange: NSRange, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        var origString = origString
        guard let origReplaceRange = Range<String.Index>.init(NSRange(location: 0, length: origSelRange.location + origSelRange.length), in: origString) else {
            tf._innerDelegate.editingChanged()
            return true
        }
        origString.replaceSubrange(origReplaceRange, with: "")
        
        var replacementString = String(partialStringPtr.pointee)
        guard let range = Range<String.Index>.init(NSRange(location: 0, length: origSelRange.location), in: replacementString) else {
            tf._innerDelegate.editingChanged()
            return true
        }
        replacementString.replaceSubrange(range, with: "")
        if let replacementRange = replacementString.range(of: origString) {
            replacementString.replaceSubrange(replacementRange, with: "")
        }
        
        if let result = tf.outsideDelegate?.textField?(self.tf, shouldChangeCharactersIn: origSelRange, replacementString: replacementString) {
            return result
        }
        if let handler = tf.properties._shouldFormatCharacters {
            let origStr = self.tf.stringValue
            handler(self.tf, origSelRange, replacementString)
            if origStr != self.tf.stringValue {
                tf._innerDelegate.editingChanged()
            }
            return false
        }
        if let handler = tf.properties._shouldChangeCharacters {
            return handler(tf, origSelRange, replacementString)
        }
        return true
    }
}
#endif
