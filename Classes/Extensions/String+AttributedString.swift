import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension String {
    /// UColor, default nil: no background
    @discardableResult
    public func background(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).background(value, at: range)
    }
    
    /// Hex color, default nil: no background
    @discardableResult
    public func background(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).background(value, at: range)
    }
    
    /// UColor, default blackColor
    @discardableResult
    public func foreground(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).foreground(value, at: range)
    }
    
    /// Hex color, default blackColor
    @discardableResult
    public func foreground(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).foreground(value, at: range)
    }
    
    @discardableResult
    public func font(v: UFont, at range: ClosedRange<Int>? = nil) -> AttributedString {
        guard let range = range else {
            return AttrStr(self).font(v: v)
        }
        return AttrStr(self).font(v: v, at: range)
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat, at range: ClosedRange<Int>? = nil) -> AttributedString {
        guard let range = range else {
            return AttrStr(self).font(identifier, size)
        }
        return AttrStr(self).font(identifier, size, at: range)
    }
    
    /// NSParagraphStyle, default defaultParagraphStyle
    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).paragraphStyle(value, at: range)
    }
    
    /// NSNumber containing integer, default 1: default ligatures, 0: no ligatures
    @discardableResult
    public func ligature(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).ligature(value, at: range)
    }
    
    /// NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
    @discardableResult
    public func kern(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).kern(value, at: range)
    }
    
    /// NSNumber containing integer, default 0: no strikethrough
    @discardableResult
    public func strikethroughStyle(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).strikethroughStyle(value, at: range)
    }
    
    /// NSNumber containing integer, default 0: no underline
    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).underlineStyle(value, at: range)
    }
    
    /// UColor, default nil: same as foreground color
    @discardableResult
    public func strokeColor(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).strokeColor(value, at: range)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func strokeColor(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).strokeColor(value, at: range)
    }
    
    /// NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
    @discardableResult
    public func strokeWidth(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).strokeWidth(value, at: range)
    }
    
    /// Shadow, default nil: no shadow
    @discardableResult
    public func shadow(offset: CGSize = .zero, blur: CGFloat = 0, color: UColor = .clear, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).shadow(offset: offset, blur: blur, color: color, at: range)
    }
    
    /// NSString, default nil: no text effect
    @discardableResult
    public func textEffect(_ value: String, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).textEffect(value, at: range)
    }
    
    /// NSTextAttachment, default nil
    @discardableResult
    public func attachment(_ value: NSTextAttachment, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).attachment(value, at: range)
    }
    
    /// NSTextAttachment(data: Data, ofType: String), default nil
    @discardableResult
    public func attachment(_ data: Data?, type: String, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).attachment(data, type: type, at: range)
    }
    
    @discardableResult
    public func link(_ value: URL, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).link(value, at: range)
    }
    
    @discardableResult
    public func link(_ value: String, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).link(value, at: range)
    }
    
    /// NSNumber containing floating point value, in points; offset from baseline, default 0
    @discardableResult
    public func baselineOffset(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).baselineOffset(value, at: range)
    }
    
    /// UIColor, default nil: same as foreground color
    @discardableResult
    public func underlineColor(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).underlineColor(value, at: range)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func underlineColor(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).underlineColor(value, at: range)
    }
    
    /// UIColor, default nil: same as foreground color
    @discardableResult
    public func strikethroughColor(_ value: UColor, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).strikethroughColor(value, at: range)
    }
    
    /// Hex color, default nil: same as foreground color
    @discardableResult
    public func strikethroughColor(_ value: Int, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).strikethroughColor(value, at: range)
    }
    
    /// NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew
    @discardableResult
    public func obliqueness(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).obliqueness(value, at: range)
    }
    
    /// NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
    @discardableResult
    public func expansion(_ value: Float, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).expansion(value, at: range)
    }
    
    @discardableResult
    public func glyphForm(_ form: AttributedString.GlyphForm, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).glyphForm(form, at: range)
    }
    
    @discardableResult
    public func writingDirection(_ direction: NSWritingDirection, at range: ClosedRange<Int>? = nil) -> AttributedString {
        AttrStr(self).writingDirection(direction, at: range)
    }
}
