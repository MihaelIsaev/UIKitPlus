import UIKit

open class Button: UIButton, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Button { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public init (_ title: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
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
        backgroundHighlighted = number.color
        return self
    }
    
    // MARK: Title
    
    @discardableResult
    public func title(_ title: String, _ state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
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
        setTitleColor(number.color, for: state)
        return self
    }
    
    // MARK: Title Font
    
    @discardableResult
    public func font(v: UIFont?) -> Self {
        titleLabel?.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    // MARK: Image
    
    @discardableResult
    public func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func image(_ imageName: String, _ state: UIControl.State = .normal) -> Self {
        setImage(UIImage(named: imageName), for: state)
        return self
    }
    
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
        return titleInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    @discardableResult
    public func imageInsets(_ insets: UIEdgeInsets) -> Self {
        imageEdgeInsets = insets
        return self
    }
    
    @discardableResult
    public func imageInsets(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        return imageInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    // MARK: TouchUpInside
    
    public typealias TapAction = ()->Void
    public typealias TapActionWithButton = (Button)->Void
    
    private var tapCallback: TapAction?
    private var tapWithButtonCallback: TapActionWithButton?
    
    @discardableResult
    public func tapAction(_ callback: @escaping TapAction) -> Self {
        tapCallback = callback
        addTarget(self, action: #selector(tapEvent), for: .touchUpInside)
        return self
    }
    
    @discardableResult
    public func tapAction(_ callback: @escaping TapActionWithButton) -> Self {
        tapWithButtonCallback = callback
        addTarget(self, action: #selector(tapEvenWithbuttont(_:)), for: .touchUpInside)
        return self
    }
    
    @objc private func tapEvent() {
        tapCallback?()
    }
    
    @objc private func tapEvenWithbuttont(_ button: Button) {
        tapWithButtonCallback?(button)
    }
}
