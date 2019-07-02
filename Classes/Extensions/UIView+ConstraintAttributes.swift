import UIKit

extension UIView {
    func xAnchorBy(_ side: NSLayoutConstraint.Attribute) -> NSLayoutAnchor<NSLayoutXAxisAnchor>? {
        switch side {
        case .leading: return leadingAnchor
        case .trailing: return trailingAnchor
        case .centerX: return centerXAnchor
        default: return nil
        }
    }
    
    func yAnchorBy(_ side: NSLayoutConstraint.Attribute) -> NSLayoutAnchor<NSLayoutYAxisAnchor>? {
        switch side {
        case .top: return topAnchor
        case .bottom: return bottomAnchor
        case .centerY: return centerYAnchor
        default: return nil
        }
    }
    
    func dimensionBy(_ side: NSLayoutConstraint.Attribute) -> NSLayoutAnchor<NSLayoutDimension>? {
        switch side {
        case .width: return widthAnchor
        case .height: return heightAnchor
        default: return nil
        }
    }
}
