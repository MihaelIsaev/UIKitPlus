import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func circle() -> Self {
        _declarativeView._circleCorners = true
        _declarativeView._customCorners = nil
        return self
    }
    
    @discardableResult
    public func corners(_ radius: CGFloat, _ corners: [UIRectCorner]) -> Self {
        _declarativeView._circleCorners = false
        _declarativeView._customCorners = nil
        guard corners.count > 0 else {
            declarativeView.layer.cornerRadius = radius
            return self
        }
        _declarativeView._customCorners = CustomCorners(radius: radius, corners: corners)
        return self
    }
    
    @discardableResult
    public func corners(_ radius: CGFloat, _ corners: UIRectCorner...) -> Self {
        return self.corners(radius, corners)
    }
}
