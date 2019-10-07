import UIKit

/// aka `UILabel`
@available(*, deprecated, renamed: "Text")
public typealias Label = Text

/// aka `UILabel`
open class Text: UILabel, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Label { self }
    public lazy var properties = Properties<Label>()
    lazy var _properties = PropertiesInternal()
    
    fileprivate var stateString: StateStringBuilder.Handler?
    private var binding: UIKitPlus.State<String>?
    
    public init (_ text: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = text
    }
    
    public init (_ state: State<String>) {
        self.binding = state
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        text = state.wrappedValue
        state.listen { _,n in self.text = n }
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
    
    public init<V>(_ expressable: ExpressableState<V, String>) {
        stateString = expressable.value
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        text = expressable.value()
        expressable.state.listen { [weak self] _,_ in self?.text = expressable.value() }
    }
    
    public init (@StateStringBuilder stateString: @escaping StateStringBuilder.Handler) {
        self.stateString = stateString
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.text = stateString()
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
    public func text(_ state: State<String>) -> Self {
        text = state.wrappedValue
        state.listen { _,n in self.text = n }
        return self
    }
    
    @discardableResult
    public func text<V>(_ expressable: ExpressableState<V, String>) -> Self {
        self.stateString = expressable.value
        text = expressable.value()
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

extension Text: Refreshable {
    /// Refreshes using `RefreshHandler`
    public func refresh() {
        if let stateString = stateString {
            text = stateString()
        }
    }
}
