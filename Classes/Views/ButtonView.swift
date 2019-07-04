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
    public func backgroundHighlighted(_ color: UIColor, _ state: UIControl.State = .normal) -> Button {
        backgroundHighlighted = color
        return self
    }
    
    @discardableResult
    public func backgroundHighlighted(_ number: Int, _ state: UIControl.State = .normal) -> Button {
        backgroundHighlighted = number.color
        return self
    }
    
    // MARK: Title
    
    @discardableResult
    public func title(_ title: String, _ state: UIControl.State = .normal) -> Button {
        setTitle(title, for: state)
        return self
    }
    
    // MARK: Title Color
    
    @discardableResult
    public func color(_ color: UIColor, _ state: UIControl.State = .normal) -> Button {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func color(_ number: Int, _ state: UIControl.State = .normal) -> Button {
        setTitleColor(number.color, for: state)
        return self
    }
    
    // MARK: Title Font
    
    @discardableResult
    public func font(v: UIFont?) -> Button {
        titleLabel?.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Button {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    // MARK: Image
    
    @discardableResult
    public func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Button {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func image(_ imageName: String, _ state: UIControl.State = .normal) -> Button {
        setImage(UIImage(named: imageName), for: state)
        return self
    }
    
    // MARK: TouchUpInside
    
    public typealias TapAction = ()->Void
    public typealias TapActionWithButton = (Button)->Void
    
    private var tapCallback: TapAction?
    private var tapWithButtonCallback: TapActionWithButton?
    
    @discardableResult
    public func tapAction(_ callback: @escaping TapAction) -> Button {
        tapCallback = callback
        addTarget(self, action: #selector(tapEvent), for: .touchUpInside)
        return self
    }
    
    @discardableResult
    public func tapAction(_ callback: @escaping TapActionWithButton) -> Button {
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
