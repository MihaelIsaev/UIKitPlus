#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    @discardableResult
    public func shadow(_ color: UColor = .black, opacity: Float = 1, x: CGFloat = 0, y: CGFloat = 0, radius: CGFloat = 10) -> Self {
        #if os(macOS)
        declarativeView.layer?.shadowColor = color.cgColor
        declarativeView.layer?.shadowOpacity = opacity
        declarativeView.layer?.shadowOffset = CGSize(width: x, height: y)
        declarativeView.layer?.shadowRadius = radius
        #else
        declarativeView.layer.shadowColor = color.cgColor
        declarativeView.layer.shadowOpacity = opacity
        declarativeView.layer.shadowOffset = CGSize(width: x, height: y)
        declarativeView.layer.shadowRadius = radius
        #endif
        return self
    }
    
    @discardableResult
    public func shadow(_ colorNumber: Int, opacity: Float = 1, x: CGFloat = 0, y: CGFloat = 0, radius: CGFloat = 10) -> Self {
        shadow(colorNumber.color, opacity: opacity, x: x, y: y, radius: radius)
    }
}
