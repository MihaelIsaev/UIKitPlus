import UIKit

open class VerificationCodeView: UIView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: VerificationCodeView { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    private let quantity: Int
    
    public typealias EnteredClosure = (String) -> Void
    private var enteredClosure: EnteredClosure  = { _ in }
    
    public init (_ quantity: Int = 4) {
        self.quantity = quantity
        super.init(frame: .zero)
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
    
    lazy var hiddenTextField = TextField().alpha(0.05)
                                                          .keyboard(.numberPad)
                                                          .editingChanged(edited)
                                                          .shouldChangeCharacters(shouldChangeCharacters)
    
    var digitViews: [DigitView] = []
    
    var widthOfDigitView: CGFloat = 24 {
        didSet {
            widthConstraints.forEach { constraint in
                constraint.constant = widthOfDigitView
            }
            layoutIfNeeded()
        }
    }
    
    var spaceBetweenDigitViews: CGFloat = 10 {
        didSet {
            spaceConstraints.forEach { constraint in
                constraint.constant = spaceBetweenDigitViews
            }
            layoutIfNeeded()
        }
    }
    
    var widthConstraints: [NSLayoutConstraint] = []
    var spaceConstraints: [NSLayoutConstraint] = []
    
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
        return digitColor(number.color)
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
        return digitBackground(number.color)
    }
    
    @discardableResult
    public func font(v: UIFont?) -> Self {
        digitViews.forEach { $0.labelFont = v }
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        return font(v: UIFont(name: identifier.fontName, size: size))
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
        if #available(iOS 12.0, *) {
            hiddenTextField.content(.oneTimeCode)
        }
        addSubview(hiddenTextField)
        NSLayoutConstraint.activate([
            hiddenTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            hiddenTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            hiddenTextField.widthAnchor.constraint(equalToConstant: 1),
            hiddenTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
        digitViews = (0...quantity - 1).map { _ in DigitView().background(digitBackground) }
        var constraints: [NSLayoutConstraint] = []
        digitViews.enumerated().forEach { offset, digitView in
            self.addSubview(digitView)
            constraints.append(digitView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
            constraints.append(digitView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
            let width = digitView.widthAnchor.constraint(equalToConstant: widthOfDigitView)
            widthConstraints.append(width)
            constraints.append(width)
            if offset == 0 {
                constraints.append(digitView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
            } else if offset > 0 {
                let prevDigit = digitViews[offset - 1]
                let space = digitView.leadingAnchor.constraint(equalTo: prevDigit.trailingAnchor, constant: self.spaceBetweenDigitViews)
                spaceConstraints.append(space)
                constraints.append(space)
            }
            if offset == digitViews.count - 1 {
                constraints.append(digitView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
            }
        }
        NSLayoutConstraint.activate(constraints)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(becomeFirstResponder)))
    }
    
    open func edited(_ textField: TextField) {
        let labels = digitViews.map { $0.label }
        for label in labels {
            label.textColor = digitColor
            guard let text = hiddenTextField.text else { continue }
            guard let index = labels.firstIndex(of: label) else { continue }
            let letters = text.map { String($0) }
            if letters.count >= index + 1 {
                label.text = String(letters[index])
                label.alpha = 1
            } else {
                label.text = ""
            }
        }
        if hiddenTextField.text?.count == digitViews.count {
            enteredClosure(hiddenTextField.text ?? "")
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
    open override func becomeFirstResponder() -> Bool {
        return hiddenTextField.becomeFirstResponder()
    }
    
    public func cleanup() {
        hiddenTextField.cleanup()
    }
}

extension VerificationCodeView {
    class DigitView: UIView, DeclarativeProtocol, DeclarativeProtocolInternal {
        public var declarativeView: DigitView { return self }
        
        var _circleCorners: Bool = false
        var _customCorners: CustomCorners?
        lazy var _borders = Borders()
        
        var _preConstraints = DeclarativePreConstraints()
        var _constraintsMain: DeclarativeConstraintsCollection = [:]
        var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
        
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
        
        var labelBackground: UIColor = .clear {
            didSet {
                label.backgroundColor = labelBackground
            }
        }
        
        var labelColor: UIColor = .black {
            didSet {
                label.color(labelColor)
            }
        }
        
        var labelFont: UIFont? = .systemFont(ofSize: 30) {
            didSet {
                label.font(v: labelFont)
            }
        }
        
        lazy var label = Label().alignment(.center)
        
        func setupView() {
            addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            ])
        }
    }
}
