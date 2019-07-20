import UIKit

open class SegmentedControl: UISegmentedControl, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: SegmentedControl { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(_ items: [SegmentControlable]) {
        super.init(items: [])
        items.enumerated().forEach { offset, item in
            switch item.item {
            case .title(let title): insertSegment(withTitle: title, at: offset, animated: false)
            case .image(let image): insertSegment(with: image, at: offset, animated: false)
            }
        }
    }
    
    public convenience init(_ items: SegmentControlable...) {
        self.init(items)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @discardableResult
    public static func items(_ items: SegmentControlable...) -> SegmentedControl {
        return SegmentedControl(items)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    @objc
    private func valueChanged() {
        _valueChanged?(selectedSegmentIndex)
    }
    
    public typealias ChangedClosure = (Int) -> Void
    
    private var _valueChanged: ChangedClosure?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func momentary(_ value: Bool = true) -> Self {
        isMomentary = value
        return self
    }
    
    @discardableResult
    public func apportionsSegmentWidthsByContent(_ value: Bool = true) -> Self {
        apportionsSegmentWidthsByContent = value
        return self
    }
    
    @discardableResult
    public func select(_ index: Int) -> Self {
        selectedSegmentIndex = index
        return self
    }
    
    @discardableResult
    public func changed(_ callback: @escaping ChangedClosure) -> Self {
        _valueChanged = callback
        return self
    }
    
    @discardableResult
    private func addAttribute(_ attr: NSAttributedString.Key, _ value: Any, for state: UIControl.State) -> Self {
        if var attributes = titleTextAttributes(for: state) {
            attributes[attr] = value
            setTitleTextAttributes(attributes, for: state)
        } else {
            setTitleTextAttributes([attr: value], for: state)
        }
        return self
    }
    
    /// UIColor, default nil: no background
    @discardableResult
    public func background(_ value: UIColor, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.backgroundColor, value, for: state)
    }
    
    /// Hex color, default nil: no background
    @discardableResult
    public func background(_ value: Int, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.backgroundColor, value.color, for: state)
    }
    
    /// UIColor, default blackColor
    @discardableResult
    public func foreground(_ value: UIColor, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.foregroundColor, value, for: state)
    }
    
    /// Hex color, default blackColor
    @discardableResult
    public func foreground(_ value: Int, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.foregroundColor, value.color, for: state)
    }
    
    @discardableResult
    public func font(v: UIFont, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.font, v, for: state)
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat, for state: UIControl.State = .normal) -> Self {
        if let value = UIFont(name: identifier.fontName, size: size) {
            addAttribute(.font, value, for: state)
        }
        return self
    }
    
    /// NSParagraphStyle, default defaultParagraphStyle
    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.paragraphStyle, value, for: state)
    }
    
    /// NSNumber containing integer, default 1: default ligatures, 0: no ligatures
    @discardableResult
    public func ligature(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.ligature, value, for: state)
    }
    
    /// NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
    @discardableResult
    public func kern(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.kern, value, for: state)
    }
    
    /// NSNumber containing integer, default 0: no strikethrough
    @discardableResult
    public func strikethroughStyle(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.strikethroughStyle, value, for: state)
    }
    
    /// NSNumber containing integer, default 0: no underline
    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.underlineStyle, value.rawValue, for: state)
    }
    
    /// UIColor, default nil: same as foreground color
    @discardableResult
    public func strokeColor(_ value: UIColor, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.strokeColor, value, for: state)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func strokeColor(_ value: Int, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.strokeColor, value.color, for: state)
    }
    
    /// NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
    @discardableResult
    public func strokeWidth(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.strokeWidth, value, for: state)
    }
    
    /// Shadow, default nil: no shadow
    @discardableResult
    public func shadow(offset: CGSize = .zero, blur: CGFloat = 0, color: UIColor = .clear, for state: UIControl.State = .normal) -> Self {
        let shadow = NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blur
        shadow.shadowColor = color
        return addAttribute(.shadow, shadow, for: state)
    }
    
    /// NSString, default nil: no text effect
    @discardableResult
    public func textEffect(_ value: String, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.textEffect, value, for: state)
    }
    
    /// NSTextAttachment, default nil
    @discardableResult
    public func attachment(_ value: NSTextAttachment, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.attachment, value, for: state)
    }
    
    /// NSTextAttachment(data: Data, ofType: String), default nil
    @discardableResult
    public func attachment(_ data: Data?, type: String, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.attachment, NSTextAttachment(data: data, ofType: type), for: state)
    }
    
    @discardableResult
    public func link(_ value: URL, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.link, value, for: state)
    }
    
    @discardableResult
    public func link(_ value: String, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.link, value, for: state)
    }
    
    /// NSNumber containing floating point value, in points; offset from baseline, default 0
    @discardableResult
    public func baselineOffset(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.baselineOffset, value, for: state)
    }
    
    /// UIColor, default nil: same as foreground color
    @discardableResult
    public func underlineColor(_ value: UIColor, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.underlineColor, value, for: state)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func underlineColor(_ value: Int, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.underlineColor, value.color, for: state)
    }
    
    /// UIColor, default nil: same as foreground color
    @discardableResult
    public func strikethroughColor(_ value: UIColor, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.strikethroughColor, value, for: state)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func strikethroughColor(_ value: Int, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.strikethroughColor, value.color, for: state)
    }
    
    /// NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew
    @discardableResult
    public func obliqueness(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.obliqueness, value, for: state)
    }
    
    /// NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
    @discardableResult
    public func expansion(_ value: Float, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.expansion, value, for: state)
    }
    
    public enum GlyphForm: Int {
        case horizontal, vertical
    }
    
    @discardableResult
    public func glyphForm(_ form: GlyphForm, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.verticalGlyphForm, form.rawValue, for: state)
    }
    
    @discardableResult
    public func writingDirection(_ direction: NSWritingDirection, for state: UIControl.State = .normal) -> Self {
        return addAttribute(.writingDirection, direction, for: state)
    }
}
