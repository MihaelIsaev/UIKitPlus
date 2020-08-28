import UIKit

public typealias UButton = Button
open class Button: UIButton, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
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
    
    var titleNormal: UIKitPlus.State<String>?
    var titleHighlighted: UIKitPlus.State<String>?
    var titleDisabled: UIKitPlus.State<String>?
    var titleSelected: UIKitPlus.State<String>?
    var titleFocused: UIKitPlus.State<String>?
    var titleApplication: UIKitPlus.State<String>?
    var titleReserved: UIKitPlus.State<String>?
    
    private var titleChangeTransition: UIView.AnimationOptions?
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        guard let transition = titleChangeTransition else {
            super.setTitle(title, for: state)
            return
        }
        UIView.transition(with: self, duration: 0.25, options: transition, animations: {
            super.setTitle(title, for: state)
        }, completion: nil)
    }
    
    open override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        guard let transition = titleChangeTransition else {
            super.setAttributedTitle(title, for: state)
            return
        }
        UIView.transition(with: self, duration: 0.25, options: transition, animations: {
            super.setAttributedTitle(title, for: state)
        }, completion: nil)
    }
    
    @discardableResult
    public func titleChangeTransition(_ value: UIView.AnimationOptions) -> Self {
        titleChangeTransition = value
        return self
    }
    
    // MARK: Initialization
    
    public init (_ title: String = "") {
        super.init(frame: .zero)
        _setup()
        setTitle(title, for: .normal)
    }
    
    public init (_ localized: LocalizedString...) {
        super.init(frame: .zero)
        _setup()
        setTitle(String(localized), for: .normal)
    }
    
    public init (_ localized: [LocalizedString]) {
        super.init(frame: .zero)
        _setup()
        setTitle(String(localized), for: .normal)
    }
    
    public init (_ state: UIKitPlus.State<String>) {
        super.init(frame: .zero)
        _setup()
        setTitle(state.wrappedValue, for: .normal)
        titleNormal = state
        titleNormal?.listen { [weak self] new in
            self?.setTitle(new, for: .normal)
        }
    }
    
    public init <V>(_ expressable: ExpressableState<V, String>) {
        super.init(frame: .zero)
        _setup()
        setTitle(expressable.value(), for: .normal)
        titleNormal = expressable.unwrap()
        titleNormal?.listen { [weak self] new in
            self?.setTitle(new, for: .normal)
        }
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
    public func title(_ localized: LocalizedString..., state: UIControl.State = .normal) -> Self {
        setTitle(String(localized), for: state)
        return self
    }
    
    @discardableResult
    public func title(_ localized: [LocalizedString], state: UIControl.State = .normal) -> Self {
        setTitle(String(localized), for: state)
        return self
    }
    
    @discardableResult
    public func title(_ bind: UIKitPlus.State<String>, state: UIControl.State = .normal) -> Self  {
        setTitle(bind.wrappedValue, for: state)
        switch state {
        case .application:
            titleApplication = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .application)
            }
        case .disabled:
            titleDisabled = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .disabled)
            }
        case .focused:
            titleFocused = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .focused)
            }
        case .highlighted:
            titleHighlighted = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .highlighted)
            }
        case .normal:
            titleNormal = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .normal)
            }
        case .reserved:
            titleReserved = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .reserved)
            }
        case .selected:
            titleSelected = bind
            bind.listen { [weak self] new in
                self?.setTitle(new, for: .selected)
            }
        default: break
        }
        return self
    }
    
    @discardableResult
    public func title<V>(_ expressable: ExpressableState<V, String>, state: UIControl.State = .normal) -> Self {
        setTitle(expressable.value(), for: .normal)
        switch state {
        case .application:
            titleApplication = expressable.unwrap()
            titleApplication?.listen { [weak self] new in
                self?.setTitle(new, for: .application)
            }
        case .disabled:
            titleDisabled = expressable.unwrap()
            titleDisabled?.listen { [weak self] new in
                self?.setTitle(new, for: .disabled)
            }
        case .focused:
            titleFocused = expressable.unwrap()
            titleFocused?.listen { [weak self] new in
                self?.setTitle(new, for: .focused)
            }
        case .highlighted:
            titleHighlighted = expressable.unwrap()
            titleHighlighted?.listen { [weak self] new in
                self?.setTitle(new, for: .highlighted)
            }
        case .normal:
            titleNormal = expressable.unwrap()
            titleNormal?.listen { [weak self] new in
                self?.setTitle(new, for: .normal)
            }
        case .reserved:
            titleReserved = expressable.unwrap()
            titleReserved?.listen { [weak self] new in
                self?.setTitle(new, for: .reserved)
            }
        case .selected:
            titleSelected = expressable.unwrap()
            titleSelected?.listen { [weak self] new in
                self?.setTitle(new, for: .selected)
            }
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
    
    // MARK: Background Image
    
    @discardableResult
    public func backgroundImage(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func backgroundImage(_ imageName: String, _ state: UIControl.State = .normal) -> Self {
        backgroundImage(UIImage(named: imageName), state)
    }
    
    @discardableResult
    public func backgroundImage(_ binding: UIKitPlus.State<UIImage>, _ state: UIControl.State = .normal) -> Self {
        binding.listen { self.image($0, state) }
        return backgroundImage(binding.wrappedValue, state)
    }
    
    @discardableResult
    public func backgroundImage<V>(_ expressable: ExpressableState<V, UIImage>, _ state: UIControl.State = .normal) -> Self {
        expressable.state.listen { _,_ in self.image(expressable.value(), state) }
        return backgroundImage(expressable.value(), state)
    }
    
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        titleLabel?.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        titleLabel?.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func contentHorizontalAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }
    
    @discardableResult
    public func contentVerticalAlignment(_ alignment: UIControl.ContentVerticalAlignment) -> Self {
        contentVerticalAlignment = alignment
        return self
    }
    
    // MARK: Mode
    
    @discardableResult
    public func mode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    // MARK: Scale Factor
    
    @discardableResult
    public func minimumScaleFactor(_ value: CGFloat) -> Self {
        titleLabel?.minimumScaleFactor = value
        return self
    }
    
    // MARK: Insets
    
    @discardableResult
    public func contentInsets(_ insets: UIEdgeInsets) -> Self {
        contentEdgeInsets = insets
        return self
    }
    
    @discardableResult
    public func contentInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        contentInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
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

extension Button: _Fontable {
    func _setFont(_ v: UIFont?) {
        titleLabel?.font = v
    }
}
