import Foundation
import UIKit

open class TextField: UITextField, UITextFieldDelegate, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TextField { self }
    public lazy var properties = Properties<TextField>()
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
    
    /// See `AnyForeacheableView`
    public lazy var isVisibleInList: Bool = !isHidden
    
    private weak var outsideDelegate: TextFieldDelegate?
    
    fileprivate var stateString: StateStringBuilder.Handler?
    private var binding: UIKitPlus.State<String>?
    
    @UIKitPlus.State private var isTyping = false
    private var typingInterval: TimeInterval = 0.5
    private var typingTimer: Timer?
    
    public init (_ text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        _setup()
    }
    
    public init (_ state: UIKitPlus.State<String>) {
        self.binding = state
        super.init(frame: .zero)
        self.text = state.wrappedValue
        state.listen { [weak self] new in self?.text = new }
        _setup()
    }
    
    public init <V>(_ expressable: ExpressableState<V, String>) {
        super.init(frame: .zero)
        self.stateString = expressable.value
        text = expressable.value()
        expressable.state.listen { [weak self] _,_ in self?.text = expressable.value() }
        _setup()
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) {
        super.init(frame: .zero)
        self.stateString = stateString
        text = stateString()
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
    
    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        addTarget(self, action: #selector(__editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(__editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(__editingDidEnd), for: .editingDidEnd)
    }
    
    @discardableResult
    public func bind(_ to: UIKitPlus.State<String>) -> Self {
        self.binding = to
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
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func secure(_ value: Bool = true) -> Self {
        isSecureTextEntry = value
        return self
    }
    
    @discardableResult
    public func secure(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { self.secure($0) }
        return secure(binding.wrappedValue)
    }
    
    @discardableResult
    public func secure<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        expressable.state.listen { _ in self.secure(expressable.value()) }
        return secure(expressable.value())
    }
    
    @discardableResult
    public func typing(_ binding: UIKitPlus.State<Bool>, _ interval: TimeInterval? = nil) -> Self {
        if let interval = interval {
            typingInterval = interval
        }
        _isTyping.listen {
            guard binding.wrappedValue != $0 else { return }
            binding.wrappedValue = $0
        }
        if binding.wrappedValue != isTyping {
            binding.wrappedValue = isTyping
        }
        return self
    }
    
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        binding?.wrappedValue = text ?? ""
        return self
    }
    
    @discardableResult
    public func text(_ attributedStrings: AttributedString...) -> Self {
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
        binding?.wrappedValue = attrStr.string
        return self
    }
    
    @discardableResult
    public func text(_ state: UIKitPlus.State<String>) -> Self {
        binding = state
        text = state.wrappedValue
        state.listen { [weak self] new in self?.text = new }
        return self
    }
    
    @discardableResult
    public func text<V>(_ expressable: ExpressableState<V, String>) -> Self {
        self.stateString = expressable.value
        text = expressable.value()
        binding = expressable.unwrap()
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
    public func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
    }
    
    @discardableResult
    public func placeholder(_ binding: UIKitPlus.State<String>) -> Self {
        binding.listen { self.placeholder($0) }
        return placeholder(binding.wrappedValue)
    }
    
    @discardableResult
    public func placeholder<V>(_ expressable: ExpressableState<V, String>) -> Self {
        expressable.state.listen { _ in self.placeholder(expressable.value()) }
        return placeholder(expressable.value())
    }
    
    @discardableResult
    public func placeholder(_ attributedStrings: AttributedString...) -> Self {
        guard !attributedStrings.isEmpty else {
            attributedPlaceholder = nil
            return self
        }
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedPlaceholder = attrStr
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: TextFieldDelegate?) -> Self {
        self.outsideDelegate = delegate
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
    public func cleanup() -> Self {
        text = ""
        __editingChanged()
        return self
    }
    
    @discardableResult
    public func leftView(_ view: UIView, mode: UITextField.ViewMode = .always) -> Self {
        leftView = view
        leftViewMode = mode
        return self
    }
    
    @discardableResult
    public func leftView(mode: UITextField.ViewMode = .always, _ view: (TextField) -> UIView) -> Self {
        leftView(view(self), mode: mode)
    }
    
    @discardableResult
    public func rightView(_ view: UIView, mode: UITextField.ViewMode = .always) -> Self {
        rightView = view
        rightViewMode = mode
        return self
    }
    
    @discardableResult
    public func rightView(mode: UITextField.ViewMode = .always, _ view: (TextField) -> UIView) -> Self {
        rightView(view(self), mode: mode)
    }
    
    @discardableResult
    public func inputView(_ view: UIView) -> Self {
        inputView = view
        return self
    }
    
    @discardableResult
    public func inputView(_ view: (TextField) -> UIView) -> Self {
        inputView(view(self))
    }
    
    @discardableResult
    public func inputAccessoryView(_ view: UIView) -> Self {
        inputAccessoryView = view
        return self
    }
    
    @discardableResult
    public func inputAccessoryView(_ view: (TextField) -> UIView) -> Self {
        inputAccessoryView(view(self))
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
    
    public typealias FormatCharactersClosure = (_ textField: TextField, _ range: NSRange, _ replacement: String) -> Void
    public typealias ChangeCharactersClosure = (_ textField: TextField, _ range: NSRange, _ replacement: String) -> Bool
    public typealias BoolClosure = (TextField) -> Bool
    public typealias VoidClosure = (TextField) -> Void
    
    private var _shouldBeginEditing: BoolClosure = { _ in return true }
    private var _didBeginEditing: [VoidClosure] = []
    private var _shouldEndEditing: BoolClosure = { _ in return true }
    private var _didEndEditing: [VoidClosure] = []
    private var _shouldFormatCharacters: FormatCharactersClosure?
    private var _shouldChangeCharacters: ChangeCharactersClosure?
    private var _shouldClear: BoolClosure = { _ in return true }
    private var _shouldReturnVoid: () -> Void = {}
    private var _shouldReturn: BoolClosure = { _ in return true }
    private var _editingDidBegin: [VoidClosure] = []
    private var _editingChanged: [VoidClosure] = []
    private var _editingDidEnd: [VoidClosure] = []
    
    @discardableResult
    public func shouldBeginEditing(_ closure: @escaping BoolClosure) -> Self {
        _shouldBeginEditing = closure
        return self
    }
    
    @discardableResult
    public func didBeginEditing(_ closure: @escaping VoidClosure) -> Self {
        _didBeginEditing.append(closure)
        return self
    }
    
    @discardableResult
    public func shouldEndEditing(_ closure: @escaping BoolClosure) -> Self {
        _shouldEndEditing = closure
        return self
    }
    
    @discardableResult
    public func didEndEditing(_ closure: @escaping VoidClosure) -> Self {
        _didEndEditing.append(closure)
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
    public func formatCharacters(_ closure: @escaping FormatCharactersClosure) -> Self {
        _shouldFormatCharacters = closure
        return self
    }
    
    @discardableResult
    public func shouldChangeCharacters(_ closure: @escaping ChangeCharactersClosure) -> Self {
        _shouldChangeCharacters = closure
        return self
    }
    
    @discardableResult
    public func shouldClear(_ closure: @escaping BoolClosure) -> Self {
        _shouldClear = closure
        return self
    }
    
    @discardableResult
    public func shouldReturn(_ closure: @escaping () -> Void) -> Self {
        _shouldReturnVoid = closure
        return self
    }
    
    @discardableResult
    public func shouldReturn(_ closure: @escaping BoolClosure) -> Self {
        _shouldReturn = closure
        return self
    }
    
    @discardableResult
    public func shouldReturnToNextResponder() -> Self {
        _shouldReturnVoid = {
            self.focusToNextResponderOrResign()
        }
        return self
    }
    
    @discardableResult
    public func editingDidBegin(_ closure: @escaping VoidClosure) -> Self {
        _editingDidBegin.append(closure)
        return self
    }
    
    @discardableResult
    public func editingChanged(_ closure: @escaping VoidClosure) -> Self {
        _editingChanged.append(closure)
        return self
    }
    
    @discardableResult
    public func editingDidEnd(_ closure: @escaping VoidClosure) -> Self {
        _editingDidEnd.append(closure)
        return self
    }
    
    @objc func __editingDidBegin() {
        _editingDidBegin.forEach { $0(self) }
    }
    
    @objc private func __invalidateTimer() {
        isTyping = false
    }
    
    @objc func __editingChanged() {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(timeInterval: typingInterval, target: self, selector: #selector(__invalidateTimer), userInfo: nil, repeats: false)
        isTyping = true
        _editingChanged.forEach { $0(self) }
        binding?.wrappedValue = self.text ?? ""
    }
    
    @objc func __editingDidEnd() {
        _editingDidEnd.forEach { $0(self) }
    }
    
    // MARK: UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return outsideDelegate?.textFieldShouldBeginEditing?(self) ?? _shouldBeginEditing(self)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        outsideDelegate?.textFieldDidBeginEditing?(self)
        _didBeginEditing.forEach { $0(self) }
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        outsideDelegate?.textFieldShouldEndEditing?(self) ?? _shouldEndEditing(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        outsideDelegate?.textFieldDidEndEditing?(self)
        _didEndEditing.forEach { $0(self) }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let result = outsideDelegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: string) {
            return result
        }
        if let handler = _shouldFormatCharacters {
            handler(self, range, string)
            __editingChanged()
            return false
        }
        if let handler = _shouldChangeCharacters {
            return handler(self, range, string)
        }
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        outsideDelegate?.textFieldShouldClear?(self) ?? _shouldClear(self)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _shouldReturnVoid()
        return outsideDelegate?.textFieldShouldReturn?(self) ?? _shouldReturn(self)
    }
}

@objc
public protocol TextFieldDelegate: NSObjectProtocol {
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldBeginEditing(_ textField: TextField) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidBeginEditing(_ textField: TextField)
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldEndEditing(_ textField: TextField) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidEndEditing(_ textField: TextField)
    
    @objc @available(iOS 10.0, *)
    optional func textFieldDidEndEditing(_ textField: TextField, reason: TextField.DidEndEditingReason)
    
    @objc @available(iOS 2.0, *)
    optional func textField(_ textField: TextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldClear(_ textField: TextField) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldReturn(_ textField: TextField) -> Bool
}

extension TextField: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = stateString {
            text = stateString()
        }
    }
}

extension TextField: _Fontable {
    func _setFont(_ v: UIFont?) {
        font = v
    }
}
