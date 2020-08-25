import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

public typealias AttrStr = AttributedString

public protocol AnyString {
    var attrString: NSAttributedString { get }
    
    static func make(_ v: NSAttributedString) -> Self
}

extension Optional: AnyString where Wrapped == AnyString {
    public var attrString: NSAttributedString {
        switch self {
        case .none: return .init()
        case .some(let str): return str.attrString
        }
    }
    
    public static func make(_ v: NSAttributedString) -> Self {
        .init(v)
    }
}

extension NSAttributedString: AnyString {
    public var attrString: NSAttributedString { self }
    
    public static func make(_ v: NSAttributedString) -> Self {
        .init(attributedString: v)
    }
}

extension String: AnyString {
    public var attrString: NSAttributedString { .init(string: self) }
    
    public static func make(_ v: NSAttributedString) -> Self {
        v.string
    }
}

open class AttributedString: AnyString {
    public var attrString: NSAttributedString { _attributedString }
    public var _attributedString: NSMutableAttributedString
    
    var _updateHandler: (AttributedString) -> Void = { _ in }
    
    public func onUpdate(_ handler: @escaping (AttributedString) -> Void) {
        _updateHandler = handler
    }
    
    public static func make(_ v: NSAttributedString) -> Self {
        .init(v)
    }
    
    public required init (_ attrString: NSAttributedString) {
        _attributedString = .init(attributedString: attrString)
    }
    
    public init (_ string: String) {
        _attributedString = .init(string: string)
    }
    
    public init (_ localized: LocalizedString...) {
        _attributedString = .init(string: String(localized))
    }
    
    public init (_ localized: [LocalizedString]) {
        _attributedString = .init(string: String(localized))
    }
    
    @discardableResult
    func addAttribute(_ attr: NSAttributedString.Key, _ value: Any, at range: ClosedRange<Int>? = nil) -> AttributedString {
        // TODO: check range
        let range = range ?? 0..._attributedString.length
        _attributedString.addAttribute(attr, value: value, range: range.nsRange)
        _updateHandler(self)
        return self
    }
    
    @discardableResult
    func removeAttribute(_ attr: NSAttributedString.Key, at range: ClosedRange<Int>? = nil) -> AttributedString {
        // TODO: check range
        let range = range ?? 0..._attributedString.length
        _attributedString.removeAttribute(attr, range: range.nsRange)
        _updateHandler(self)
        return self
    }
    
    /// UColor, default nil: no background
    @discardableResult
    public func background(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.backgroundColor, value.current, at: range)
    }
    
    /// Hex color, default nil: no background
    @discardableResult
    public func background(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.backgroundColor, value.color.current, at: range)
    }
    
    /// UColor, default blackColor
    @discardableResult
    public func foreground(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.foregroundColor, value.current, at: range)
    }
    
    /// Hex color, default blackColor
    @discardableResult
    public func foreground(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.foregroundColor, value.color.current, at: range)
    }
    
    /// NSParagraphStyle, default defaultParagraphStyle
    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.paragraphStyle, value, at: range)
    }
    
    /// NSNumber containing integer, default 1: default ligatures, 0: no ligatures
    @discardableResult
    public func ligature(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.ligature, value, at: range)
    }
    
    /// NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
    @discardableResult
    public func kern(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.kern, value, at: range)
    }
    
    /// NSNumber containing integer, default 0: no strikethrough
    @discardableResult
    public func strikethroughStyle(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.strikethroughStyle, value, at: range)
    }
    
    /// NSNumber containing integer, default 0: no underline
    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.underlineStyle, value.rawValue, at: range)
    }
    
    /// UColor, default nil: same as foreground color
    @discardableResult
    public func strokeColor(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.strokeColor, value.current, at: range)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func strokeColor(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.strokeColor, value.color.current, at: range)
    }
    
    /// NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
    @discardableResult
    public func strokeWidth(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.strokeWidth, value, at: range)
    }
    
    /// Shadow, default nil: no shadow
    @discardableResult
    public func shadow(offset: CGSize = .zero, blur: CGFloat = 0, color: UColor = .clear, at range: ClosedRange<Int>? = nil) -> AttributedString {
        let shadow = NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blur
        #if os(macOS)
        shadow.shadowColor = color.current
        color.onChange { [weak shadow] new in
            shadow?.shadowColor = new
        }
        #else
        shadow.shadowColor = color
        #endif
        return addAttribute(.shadow, shadow, at: range)
    }
    
    /// NSString, default nil: no text effect
    @discardableResult
    public func textEffect(_ value: String, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.textEffect, value, at: range)
    }
    
    /// NSTextAttachment, default nil
    @discardableResult
    public func attachment(_ value: NSTextAttachment, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.attachment, value, at: range)
    }
    
    /// NSTextAttachment(data: Data, ofType: String), default nil
    @discardableResult
    public func attachment(_ data: Data?, type: String, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.attachment, NSTextAttachment(data: data, ofType: type), at: range)
    }
    
    @discardableResult
    public func link(_ value: URL, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.link, value, at: range)
    }
    
    @discardableResult
    public func link(_ value: String, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.link, value, at: range)
    }
    
    /// NSNumber containing floating point value, in points; offset from baseline, default 0
    @discardableResult
    public func baselineOffset(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.baselineOffset, value, at: range)
    }
    
    /// UColor, default nil: same as foreground color
    @discardableResult
    public func underlineColor(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.underlineColor, value.current, at: range)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func underlineColor(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.underlineColor, value.color.current, at: range)
    }
    
    /// UColor, default nil: same as foreground color
    @discardableResult
    public func strikethroughColor(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.strikethroughColor, value.current, at: range)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func strikethroughColor(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.strikethroughColor, value.color.current, at: range)
    }
    
    /// NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew
    @discardableResult
    public func obliqueness(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.obliqueness, value, at: range)
    }
    
    /// NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
    @discardableResult
    public func expansion(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.expansion, value, at: range)
    }
    
    public enum GlyphForm: Int {
        case horizontal, vertical
    }
    
    @discardableResult
    public func glyphForm(_ form: GlyphForm, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.verticalGlyphForm, form.rawValue, at: range)
    }
    
    @discardableResult
    public func writingDirection(_ direction: NSWritingDirection, at range: ClosedRange<Int>? = nil) -> AttributedString {
        addAttribute(.writingDirection, direction, at: range)
    }
}

extension AttrStr: _FontableAtRange {
    func _setFont(_ v: UFont?) {
        guard let v = v else {
            removeAttribute(.font)
            return
        }
        addAttribute(.font, v)
    }
    
    public func font(v: UFont?, at range: ClosedRange<Int>) -> Self {
        guard let v = v else {
            removeAttribute(.font, at: range)
            return self
        }
        addAttribute(.font, v, at: range)
        return self
    }
}
