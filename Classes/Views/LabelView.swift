import UIKit

open class Label: UILabel, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Label { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public init (_ text: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = text
    }
    
    public init (_ attributedStrings: AttributedString...) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
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
    
    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func text(_ attributedStrings: AttributedString...) -> Self {
        let attrStr = NSMutableAttributedString(string: "")
        attributedStrings.forEach {
            attrStr.append($0.attributedString)
        }
        attributedText = attrStr
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
    public func font(v: UIFont?) -> Self {
        self.font = v
        return self
    }
    
    @discardableResult
    public func minimumScaleFactor(_ value: CGFloat) -> Self {
        self.minimumScaleFactor = value
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool = true) -> Self {
        self.adjustsFontSizeToFitWidth = value
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
    public func lines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    @discardableResult
    public func multiline() -> Self {
        numberOfLines = 0
        return self
    }
}
