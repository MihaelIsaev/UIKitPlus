import UIKit

open class VerificationCodeView: UIView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: VerificationCodeView { self }
    public lazy var properties = Properties<VerificationCodeView>()
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
    
    private let quantity: Int
    
    public typealias EnteredClosure = (String) -> Void
    private var enteredClosure: EnteredClosure  = { _ in }
    private var simpleEnteredClosure  = {}
    
    var bindCode: UState<String>?
    
    public init (_ quantity: Int = 4, _ state: UState<String>) {
        self.quantity = quantity
        super.init(frame: .zero)
        bindCode = state
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    public init<V>(_ quantity: Int = 4, _ expressable: ExpressableState<V, String>) {
        self.quantity = quantity
        super.init(frame: .zero)
        bindCode = expressable.unwrap()
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    public override init(frame: CGRect) {
        quantity = 4
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
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
    
    lazy var hiddenTextField = TextField().edgesToSuperview(top: 0, leading: 0)
                                                          .alpha(0.05)
                                                          .keyboard(.numberPad)
                                                          .editingChanged(edited)
                                                          .shouldChangeCharacters(shouldChangeCharacters)
    
    var digitViews: [DigitView] = []
    
    var isSecureField = false {
        didSet {
            edited(hiddenTextField)
        }
    }
    var secureSymbol = "∙" {
        didSet {
            edited(hiddenTextField)
        }
    }
    
    @UState var widthOfDigitView: CGFloat = 24
    @UState var spaceBetweenDigitViews: CGFloat = 10
    
    public var code: String {
        return hiddenTextField.text ?? ""
    }
    
    @discardableResult
    public func secured(_ value: Bool = true) -> Self {
        isSecureField = value
        return self
    }
    
    @discardableResult
    public func secureSymbol(_ value: String) -> Self {
        secureSymbol = value
        return self
    }
    
    @discardableResult
    public func digitWidth(_ value: CGFloat) -> Self {
        widthOfDigitView = value
        return self
    }
    
    @discardableResult
    public func digitsMargin(_ margin: CGFloat) -> Self {
        spaceBetweenDigitViews = margin
        return self
    }
    
    private var digitColor: UIColor = .black
    
    @discardableResult
    public func digitColor(_ color: UIColor) -> Self {
        digitColor = color
        digitViews.forEach { $0.labelColor = color }
        return self
    }
    
    @discardableResult
    public func digitColor(_ number: Int) -> Self {
        digitColor(number.color)
    }
    
    var digitBackground: UIColor = .clear
    
    @discardableResult
    public func digitBackground(_ color: UIColor) -> Self {
        digitBackground = color
        digitViews.forEach { $0.labelBackground = color }
        return self
    }
    
    @discardableResult
    public func digitBackground(_ number: Int) -> Self {
        digitBackground(number.color)
    }
    
    @discardableResult
    public func digitCorners(_ radius: CGFloat, _ corners: UIRectCorner...) -> Self {
        digitViews.forEach { $0.label.corners(radius, corners) }
        return self
    }
    
    @discardableResult
    public func digitBorder(_ width: CGFloat, _ color: UIColor) -> Self {
        digitViews.forEach { $0.label.border(width, color) }
        return self
    }
    
    @discardableResult
    public func digitBorder(_ width: CGFloat, _ number: Int) -> Self {
        digitBorder(width, number.color)
        return self
    }
    
    @discardableResult
    public func digitBorder(_ side: Borders.Side, _ width: CGFloat, _ color: UIColor) -> Self {
        digitViews.forEach { $0.label.border(side, width, color) }
        return self
    }
    
    @discardableResult
    public func digitBorder(_ side: Borders.Side, _ width: CGFloat, _ number: Int) -> Self {
        digitBorder(side, width, number.color)
        return self
    }
    
    @discardableResult
    public func removeDigitBorder(_ side: Borders.Side) -> Self {
        digitViews.forEach { $0.label.removeBorder(side) }
        return self
    }
    
    func setupView() {
        digitViews = (0...quantity - 1).map { _ in DigitView().background(digitBackground).width($widthOfDigitView) }
        body {
            hiddenTextField.size(1, 30).content(.oneTimeCode)
            HStack {
                digitViews
            }.spacing($spaceBetweenDigitViews).edgesToSuperview()
        }
        onTapGesture { self.becomeFirstResponder() }
    }
    
    open func edited(_ textField: TextField) {
        let labels = digitViews.map { $0.label }
        for label in labels {
            label.textColor = digitColor
            guard let text = hiddenTextField.text else { continue }
            guard let index = labels.firstIndex(of: label) else { continue }
            let letters = text.map { String($0) }
            if letters.count >= index + 1 {
                label.text = isSecureField ? secureSymbol : String(letters[index])
                label.alpha = 1
            } else {
                label.text = ""
            }
        }
        bindCode?.wrappedValue = hiddenTextField.text ?? ""
        if hiddenTextField.text?.count == digitViews.count {
            enteredClosure(hiddenTextField.text ?? "")
            simpleEnteredClosure()
        }
    }
    
    func shouldChangeCharacters(_ textField: TextField, range: NSRange, replacement: String) -> Bool {
        guard !replacement.isEmpty else { return true }
        if textField.text?.count == digitViews.count {
            textField.text = replacement
            edited(textField)
            return false
        }
        return true
    }
    
    @discardableResult
    public func entered(_ closure: @escaping EnteredClosure) -> Self {
        enteredClosure = closure
        return self
    }
    
    @discardableResult
    public func entered(_ closure: @escaping () -> Void) -> Self {
        simpleEnteredClosure = closure
        return self
    }
    
    @discardableResult
    public func keyboardAppearance(_ appearance: UIKeyboardAppearance) -> Self {
        hiddenTextField.keyboardAppearance = appearance
        return self
    }
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        hiddenTextField.becomeFirstResponder()
    }
    
    public func cleanup() {
        hiddenTextField.cleanup()
    }
}

extension VerificationCodeView: _Fontable {
    func _setFont(_ v: UIFont?) {
        digitViews.forEach { $0.labelFont = v }
    }
}

extension VerificationCodeView {
    class DigitView: UIView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
        public var declarativeView: DigitView { self }
        public lazy var properties = Properties<DigitView>()
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
        
        public init () {
            super.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false
            setupView()
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = false
            setupView()
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
        
        @UState var labelBackground: UIColor = .clear
        @UState var labelColor: UIColor = .black
        
        var labelFont: UIFont? = .systemFont(ofSize: 30) {
            didSet {
                label.font(v: labelFont)
            }
        }
        
        lazy var label = Text()
        
        func setupView() {
            body {
                label.alignment(.center).edgesToSuperview().color($labelColor).font(v: labelFont).background($labelBackground)
            }
        }
    }
}
