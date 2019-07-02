import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func shadow(_ color: UIColor = .black, opacity: Float = 1, offset: CGSize = .zero, radius: CGFloat = 10) -> Self {
        declarativeView.layer.shadowColor = color.cgColor
        declarativeView.layer.shadowOpacity = opacity
        declarativeView.layer.shadowOffset = offset
        declarativeView.layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    public func shadow(_ colorNumber: Int, opacity: Float = 1, offset: CGSize = .zero, radius: CGFloat = 10) -> Self {
        return shadow(colorNumber.color, opacity: opacity, offset: offset, radius: radius)
    }
}
