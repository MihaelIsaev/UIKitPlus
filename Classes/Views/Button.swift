import UIKit

open class Button: UIButton, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Button { self }
    public lazy var properties = Properties<Button>()
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
    
    // MARK: States
    
    var titleNormal: UIKitPlus.State<String>? {
        didSet {
             titleNormal?.listen { [weak self] in
                 self?.setTitle($0, for: .normal)
             }
        }
    }
    var titleHighlighted: UIKitPlus.State<String>? {
        didSet {
            titleNormal?.listen { [weak self] in
                self?.setTitle($0, for: .highlighted)
            }
        }
    }
    var titleDisabled: UIKitPlus.State<String>? {
        didSet {
            titleNormal?.listen { [weak self] in
                self?.setTitle($0, for: .disabled)
            }
        }
    }
    var titleSelected: UIKitPlus.State<String>? {
        didSet {
            titleNormal?.listen { [weak self] in
                self?.setTitle($0, for: .selected)
            }
        }
    }
    var titleFocused: UIKitPlus.State<String>? {
        didSet {
            titleNormal?.listen { [weak self] in
                self?.setTitle($0, for: .focused)
            }
        }
    }
    var titleApplication: UIKitPlus.State<String>? {
        didSet {
            titleNormal?.listen { [weak self] in
                self?.setTitle($0, for: .application)
            }
        }
    }
    var titleReserved: UIKitPlus.State<String>? {
        didSet {
            titleNormal?.listen { [weak self] in
                self?.setTitle($0, for: .reserved)
            }
        }
    }
    
    // MARK: Initialization
    
    public init (_ title: String = "") {
        super.init(frame: .zero)
        _setup()
        setTitle(title, for: .normal)
    }
    
    public init (_ state: UIKitPlus.State<String>) {
        super.init(frame: .zero)
        _setup()
        setTitle(state.wrappedValue, for: .normal)
        titleNormal = state
    }
    
    public init <V>(_ expressable: ExpressableState<V, String>) {
        super.init(frame: .zero)
        _setup()
        setTitle(expressable.value(), for: .normal)
        titleNormal = expressable.unwrap()
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
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    open override var isHighlighted: Bool {
        didSet {
            if originalBackground == nil {
                originalBackground = backgroundColor
            }
            if isHighlighted {
                backgroundColor = backgroundHighlighted ?? backgroundColor
            } else {
                backgroundColor = originalBackground ?? backgroundColor
            }
        }
    }
    
    // MARK: Background Highlighted
    
    var originalBackground: UIColor?
    var backgroundHighlighted: UIColor?
    
    @discardableResult
    public func backgroundHighlighted(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        backgroundHighlighted = color
        return self
    }
    
    @discardableResult
    public func backgroundHighlighted(_ number: Int, _ state: UIControl.State = .normal) -> Self {
        backgroundHighlighted(number.color)
    }
    
    // MARK: Title
    
    @discardableResult
    public func title(_ title: String, _ state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    public func title(_ bind: UIKitPlus.State<String>, state: UIControl.State = .normal) -> Self  {
        setTitle(bind.wrappedValue, for: state)
        switch state {
        case .application: titleApplication = bind
        case .disabled: titleDisabled = bind
        case .focused: titleFocused = bind
        case .highlighted: titleHighlighted = bind
        case .normal: titleNormal = bind
        case .reserved: titleReserved = bind
        case .selected: titleSelected = bind
        default: break
        }
        return self
    }
    
    @discardableResult
    public func title<V>(_ expressable: ExpressableState<V, String>, state: UIControl.State = .normal) -> Self {
        setTitle(expressable.value(), for: .normal)
        switch state {
        case .application: titleApplication = expressable.unwrap()
        case .disabled: titleDisabled = expressable.unwrap()
        case .focused: titleFocused = expressable.unwrap()
        case .highlighted: titleHighlighted = expressable.unwrap()
        case .normal: titleNormal = expressable.unwrap()
        case .reserved: titleReserved = expressable.unwrap()
        case .selected: titleSelected = expressable.unwrap()
        default: break
        }
        return self
    }
    
    // MARK: Title Color
    
    @discardableResult
    public func color(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func color(_ number: Int, _ state: UIControl.State = .normal) -> Self {
        color(number.color, state)
    }
    
    @discardableResult
    public func color(_ binding: UIKitPlus.State<UIColor>, _ state: UIControl.State = .normal) -> Self {
        binding.listen { self.color($0, state) }
        return color(binding.wrappedValue, state)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, UIColor>, _ state: UIControl.State = .normal) -> Self {
        expressable.state.listen { _,_ in self.color(expressable.value(), state) }
        return color(expressable.value(), state)
    }
    
    @discardableResult
    public func color(_ binding: UIKitPlus.State<Int>, _ state: UIControl.State = .normal) -> Self {
        binding.listen { self.color($0, state) }
        return color(binding.wrappedValue, state)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, Int>, _ state: UIControl.State = .normal) -> Self {
        expressable.state.listen { _,_ in self.color(expressable.value(), state) }
        return color(expressable.value(), state)
    }
    
    // MARK: Title Font
    
    @discardableResult
    public func font(v: UIFont?) -> Self {
        titleLabel?.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func font(_ binding: UIKitPlus.State<UIFont>) -> Self {
        binding.listen { self.font(v: $0) }
        return font(v: binding.wrappedValue)
    }
    
    @discardableResult
    public func font<V>(_ expressable: ExpressableState<V, UIFont>) -> Self {
        expressable.state.listen { _ in self.font(v: expressable.value()) }
        return font(v: expressable.value())
    }
    
    // MARK: Image
    
    @discardableResult
    public func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func image(_ imageName: String, _ state: UIControl.State = .normal) -> Self {
        image(UIImage(named: imageName), state)
    }
    
    @discardableResult
    public func image(_ binding: UIKitPlus.State<UIImage>, _ state: UIControl.State = .normal) -> Self {
        binding.listen { self.image($0, state) }
        return image(binding.wrappedValue, state)
    }
    
    @discardableResult
    public func image<V>(_ expressable: ExpressableState<V, UIImage>, _ state: UIControl.State = .normal) -> Self {
        expressable.state.listen { _,_ in self.image(expressable.value(), state) }
        return image(expressable.value(), state)
    }
    
    // MARK: Mode
    
    @discardableResult
    public func mode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    // MARK: Insets
    
    @discardableResult
    public func titleInsets(_ insets: UIEdgeInsets) -> Self {
        titleEdgeInsets = insets
        return self
    }
    
    @discardableResult
    public func titleInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        titleInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    @discardableResult
    public func imageInsets(_ insets: UIEdgeInsets) -> Self {
        imageEdgeInsets = insets
        return self
    }
    
    @discardableResult
    public func imageInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        imageInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
}
