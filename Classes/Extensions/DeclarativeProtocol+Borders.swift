import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func border(_ width: CGFloat, _ color: CGColor) -> Self {
        _declarativeView._borders.views.forEach { $0.value.removeFromSuperview() }
        _declarativeView._borders.views.removeAll()
        declarativeView.layer.borderWidth = width
        declarativeView.layer.borderColor = color
        return self
    }
    
    @discardableResult
    public func border(_ width: CGFloat, _ color: UIColor) -> Self {
        return border(width, color.cgColor)
    }
    
    @discardableResult
    public func border(_ width: CGFloat, _ colorNumber: Int) -> Self {
        return border(width, colorNumber.color.cgColor)
    }
    
    @discardableResult
    public func border(_ side: Borders.Side, _ width: CGFloat, _ color: UIColor) -> Self {
        let border = View().background(color)
        declarativeView.addSubview(border)
        switch side {
        case .top:
            NSLayoutConstraint.activate([
                border.leadingAnchor.constraint(equalTo: declarativeView.leadingAnchor),
                border.trailingAnchor.constraint(equalTo: declarativeView.trailingAnchor),
                border.topAnchor.constraint(equalTo: declarativeView.topAnchor),
                border.heightAnchor.constraint(equalToConstant: width)
                ])
        case .left:
            NSLayoutConstraint.activate([
                border.leadingAnchor.constraint(equalTo: declarativeView.leadingAnchor),
                border.topAnchor.constraint(equalTo: declarativeView.topAnchor),
                border.bottomAnchor.constraint(equalTo: declarativeView.bottomAnchor),
                border.widthAnchor.constraint(equalToConstant: width)
                ])
        case .right:
            NSLayoutConstraint.activate([
                border.trailingAnchor.constraint(equalTo: declarativeView.trailingAnchor),
                border.topAnchor.constraint(equalTo: declarativeView.topAnchor),
                border.bottomAnchor.constraint(equalTo: declarativeView.bottomAnchor),
                border.widthAnchor.constraint(equalToConstant: width)
                ])
        case .bottom:
            NSLayoutConstraint.activate([
                border.leadingAnchor.constraint(equalTo: declarativeView.leadingAnchor),
                border.trailingAnchor.constraint(equalTo: declarativeView.trailingAnchor),
                border.bottomAnchor.constraint(equalTo: declarativeView.bottomAnchor),
                border.heightAnchor.constraint(equalToConstant: width)
                ])
        }
        _declarativeView._borders.views[side]?.removeFromSuperview()
        _declarativeView._borders.views.removeValue(forKey: side)
        return self
    }
    
    @discardableResult
    public func border(_ side: Borders.Side, _ width: CGFloat, _ colorNumber: Int) -> Self {
        return border(side, width, colorNumber.color)
    }
    
    @discardableResult
    public func removeBorder(_ side: Borders.Side) -> Self {
        _declarativeView._borders.views[side]?.removeFromSuperview()
        _declarativeView._borders.views.removeValue(forKey: side)
        return self
    }
}
