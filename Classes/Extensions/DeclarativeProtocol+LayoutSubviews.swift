import UIKit

extension DeclarativeProtocol {
    func onLayoutSubviews() {
        if _declarativeView._circleCorners == true {
            if let minSide = [declarativeView.bounds.size.width, declarativeView.bounds.size.height].min() {
                declarativeView.layer.cornerRadius = minSide / 2
            }
        } else if let customCorners = _declarativeView._customCorners {
            declarativeView.layer.cornerRadius = 0
            let path = UIBezierPath(roundedRect: declarativeView.bounds,
                                    byRoundingCorners: UIRectCorner(customCorners.corners),
                                    cornerRadii: CGSize(width: customCorners.radius, height: customCorners.radius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            declarativeView.layer.mask = maskLayer
        }
    }
}
