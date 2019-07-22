import UIKit

open class TextField: UITextField, UITextFieldDelegate, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: TextField { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    private weak var outsideDelegate: TextFieldDelegate?
    
    public init (_ text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        addTarget(self, action: #selector(__editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(__editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(__editingDidEnd), for: .editingDidEnd)
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
    public func font(v: UIFont?) -> Self {
        self.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func secure() -> Self {
        isSecureTextEntry = true
        return self
    }
    
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
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
        return leftView(view(self), mode: mode)
    }
    
    @discardableResult
    public func rightView(_ view: UIView, mode: UITextField.ViewMode = .always) -> Self {
        rightView = view
        rightViewMode = mode
        return self
    }
    
    @discardableResult
    public func rightView(mode: UITextField.ViewMode = .always, _ view: (TextField) -> UIView) -> Self {
        return rightView(view(self), mode: mode)
    }
    
    @discardableResult
    public func inputView(_ view: UIView) -> Self {
        inputView = view
        return self
    }
    
    @discardableResult
    public func inputView(_ view: (TextField) -> UIView) -> Self {
        return inputView(view(self))
    }
    
    // MARK: Delegate Closures
    
    public typealias ChangeCharactersClosure = (_ textField: TextField, _ range: NSRange, _ replacement: String) -> Bool
    public typealias BoolClosure = (TextField) -> Bool
    public typealias VoidClosure = (TextField) -> Void
    
    private var _shouldBeginEditing: BoolClosure = { _ in return true }
    private var _didBeginEditing: [VoidClosure] = []
    private var _shouldEndEditing: BoolClosure = { _ in return true }
    private var _didEndEditing: [VoidClosure] = []
    private var _shouldChangeCharacters: ChangeCharactersClosure = { _,_,_  in return true }
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
    
    @objc func __editingChanged() {
        _editingChanged.forEach { $0(self) }
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
        return outsideDelegate?.textFieldShouldEndEditing?(self) ?? _shouldEndEditing(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        outsideDelegate?.textFieldDidEndEditing?(self)
        _didEndEditing.forEach { $0(self) }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return outsideDelegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: string)
            ?? _shouldChangeCharacters(self, range, string)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return outsideDelegate?.textFieldShouldClear?(self) ?? _shouldClear(self)
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
