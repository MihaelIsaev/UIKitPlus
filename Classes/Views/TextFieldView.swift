#if !os(macOS)
import Foundation
import UIKit

public typealias UTextField = TextField
open class TextField: UITextField, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TextField { self }
    public typealias P = Properties<TextField>
    public lazy var properties = P()
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
    
    fileprivate weak var outsideDelegate: TextFieldDelegate?
    
    public init (_ text: String?) {
        super.init(frame: .zero)
        self.text(text ?? "")
        _setup()
    }
    
    public init (_ localized: LocalizedString...) {
        super.init(frame: .zero)
        self.text(text ?? "")
        _setup()
    }
    
    public init (_ localized: [LocalizedString]) {
        super.init(frame: .zero)
        self.text(text ?? "")
        _setup()
    }
    
    public init (_ state: UIKitPlus.State<String>) {
        super.init(frame: .zero)
        text(state)
        _setTextBind(state)
        _setup()
    }
    
    public init <V>(_ expressable: ExpressableState<V, String>) {
        super.init(frame: .zero)
        let state = expressable.unwrap()
        text(state)
        _setTextBind(state)
        _setup()
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) {
        super.init(frame: .zero)
        text(stateString())
        _setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
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
    
    fileprivate lazy var _innerDelegate = _InnerDelegate(self)
    
    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = _innerDelegate
    }
    
    @discardableResult
    public func delegate(_ delegate: TextFieldDelegate?) -> Self {
        self.outsideDelegate = delegate
        return self
    }
    
    var textRect: CGRect?
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let textRect = textRect {
            return textRect
        }
        return super.textRect(forBounds: bounds)
    }
        
    @discardableResult
    public func textInsets(_ insets: UIEdgeInsets) -> Self {
        textRect = bounds.inset(by: insets)
        return self
    }
    
    @discardableResult
    public func textInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        textInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    var editingRect: CGRect?
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let editingRect = editingRect {
            return editingRect
        }
        return super.editingRect(forBounds: bounds)
    }
    
    @discardableResult
    public func editingInsets(_ insets: UIEdgeInsets) -> Self {
        editingRect = bounds.inset(by: insets)
        return self
    }
    
    @discardableResult
    public func editingInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        editingInsets(.init(top: top, left: left, bottom: bottom, right: right))
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
    ///             .placeholder(AttrStr("(555) 123-4567").foreground(.darkGrey).font(.articoRegular, 15))
    ///             .color(.blackHole)
    ///             .height(18)
    ///             .formatCharacters { textView, range, text in
    ///                 let result = phoneFormatter.formatInput(currentText: textView.text ?? "", range: range, replacementString: text)
    ///                 textView.text = result.formattedText
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
    
    @discardableResult
    public func shouldReturn(_ closure: @escaping () -> Void) -> Self {
        properties._shouldReturnVoid = closure
        return self
    }
    
    @discardableResult
    public func shouldReturn(_ closure: @escaping P.BoolClosure) -> Self {
        properties._shouldReturn = closure
        return self
    }
    
    @discardableResult
    public func shouldReturnToNextResponder() -> Self {
        properties._shouldReturnVoid = {
            self.focusToNextResponderOrResign()
        }
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
    
    public func `return`() {
        _ = _innerDelegate.textFieldShouldReturn(self)
    }
}

fileprivate class _InnerDelegate: NSObject, UITextFieldDelegate {
    let parent: TextField
    
    init (_ textField: TextField) {
        parent = textField
        super.init()
        parent.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        parent.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        parent.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
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
        parent._properties.textBinding?.wrappedValue = parent.text ?? ""
    }
    
    @objc func editingDidEnd() {
        parent.properties._editingDidEnd.forEach { $0(self.parent) }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        parent.outsideDelegate?.textFieldShouldBeginEditing?(parent) ?? parent.properties._shouldBeginEditing(parent)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        parent.outsideDelegate?.textFieldDidBeginEditing?(parent)
        parent.properties._didBeginEditing.forEach { $0(self.parent) }
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        parent.outsideDelegate?.textFieldShouldEndEditing?(parent) ?? parent.properties._shouldEndEditing(parent)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        parent.outsideDelegate?.textFieldDidEndEditing?(parent)
        parent.properties._didEndEditing.forEach { $0(self.parent) }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let result = parent.outsideDelegate?.textField?(self.parent, shouldChangeCharactersIn: range, replacementString: string) {
            return result
        }
        if let handler = parent.properties._shouldFormatCharacters {
            handler(self.parent, range, string)
            editingChanged()
            return false
        }
        if let handler = parent.properties._shouldChangeCharacters {
            return handler(self.parent, range, string)
        }
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        parent.outsideDelegate?.textFieldShouldClear?(parent) ?? parent.properties._shouldClear(parent)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parent.properties._shouldReturnVoid()
        return parent.outsideDelegate?.textFieldShouldReturn?(parent) ?? parent.properties._shouldReturn(parent)
    }
}

extension TextField: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = _properties.stateString {
            text = stateString()
        }
    }
}

extension TextField: _Enableable {
    func _setEnabled(_ v: Bool) {
        isEnabled = v
    }
}

extension TextField: _Fontable {
    func _setFont(_ v: UIFont?) {
        font = v
    }
}

extension TextField: _Cleanupable {
    func _cleanup() {
        text = ""
        _innerDelegate.editingChanged()
    }
}

extension TextField: _Colorable {
    var _colorState: UIKitPlus.State<UIColor> { properties.textColorState }
    
    func _setColor(_ v: UIColor?) {
        textColor = v
        properties.textColor = v ?? .clear
    }
}

extension TextField: _TextAligmentable {
    func _setTextAlignment(v: NSTextAlignment) {
        textAlignment = v
    }
}

extension TextField: _Secureable {
    func _setSecure(_ v: Bool) {
        isSecureTextEntry = v
    }
}

extension TextField: _TextBindable {
    func _setTextBind(_ binding: UIKitPlus.State<String>?) {
        _properties.textBinding = binding
    }
}

extension TextField: _Textable {
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
    func _setPlaceholder(_ v: String) {
        placeholder = v
    }
    
    func _setPlaceholder(_ v: AttrStr?) {
        attributedPlaceholder = v?.attributedString
    }
}

extension TextField: _Keyboardable {
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
}

extension TextField: _TextAutocapitalizationable {
    func _setTextAutocapitalizationType(_ v: UITextAutocapitalizationType) {
        autocapitalizationType = v
    }
}

extension TextField: _TextAutocorrectionable {
    func _setTextAutocorrectionType(_ v: UITextAutocorrectionType) {
        autocorrectionType = v
    }
}

extension TextField: _TextFieldContentTypeable {
    func _setTextFieldContentType(v: TextFieldContentType) {
        if #available(iOS 10.0, *) {
            if let type = v.type {
                textContentType = type
            }
        }
    }
}

extension TextField: _TextFieldLeftViewable {
    func _setLeftView(v: UIView) {
        leftView = v
    }
    
    func _setLeftViewMode(v: UITextField.ViewMode) {
        leftViewMode = v
    }
    
    @discardableResult
    public func leftView(_ view: @escaping (TextField) -> UIView) -> Self {
        leftView(mode: .always) { view(self) }
    }
    
    @discardableResult
    public func leftView(mode: UITextField.ViewMode, _ view: @escaping (TextField) -> UIView) -> Self {
        leftView(mode: mode) { view(self) }
    }
}

extension TextField: _TextFieldRightViewable {
    func _setRightView(v: UIView) {
        rightView = v
    }
    
    func _setRightViewMode(v: UITextField.ViewMode) {
        rightViewMode = v
    }
    
    @discardableResult
    public func rightView(_ view: @escaping (TextField) -> UIView) -> Self {
        rightView(mode: .always) { view(self) }
    }
    
    @discardableResult
    public func rightView(mode: UITextField.ViewMode, _ view: @escaping (TextField) -> UIView) -> Self {
        rightView(mode: mode) { view(self) }
    }
}
#endif
