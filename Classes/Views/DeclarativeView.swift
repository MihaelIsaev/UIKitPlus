//
//  DeclarativeView.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 29/06/2019.
//

import UIKit

public protocol DeclarativeView: class {
    associatedtype V: UIView = Self
    
    var declarativeView: V { get }
    
    var _circleCorners: Bool { get set }
    var _customCorners: CustomCorners? { get set }
    var _borders: Borders { get }
}

extension DeclarativeView {
    // MARK: Background Color
    
    @discardableResult
    public func background(_ color: UIColor) -> Self {
        declarativeView.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func background(_ number: Int) -> Self {
        declarativeView.backgroundColor = number.color
        return self
    }
    
    // MARK: Tint Color
    
    @discardableResult
    public func tint(_ color: UIColor) -> Self {
        declarativeView.tintColor = color
        return self
    }
    
    @discardableResult
    public func tint(_ number: Int) -> Self {
        declarativeView.tintColor = number.color
        return self
    }
    
    // MARK: Corner Radius
    
    @discardableResult
    public func circle() -> Self {
        _circleCorners = true
        _customCorners = nil
        return self
    }
    
    @discardableResult
    public func corners(_ radius: CGFloat, _ corners: UIRectCorner...) -> Self {
        _circleCorners = false
        _customCorners = nil
        guard corners.count > 0 else {
            declarativeView.layer.cornerRadius = radius
            return self
        }
        _customCorners = CustomCorners(radius: radius, corners: corners)
        return self
    }
    
    // MARK: Border
    
    @discardableResult
    public func border(_ width: CGFloat, _ color: CGColor) -> Self {
        _borders.views.forEach { $0.value.removeFromSuperview() }
        _borders.views.removeAll()
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
    
    @available(iOS 9.0, *)
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
        _borders.views[side]?.removeFromSuperview()
        _borders.views.removeValue(forKey: side)
        return self
    }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func border(_ side: Borders.Side, _ width: CGFloat, _ colorNumber: Int) -> Self {
        return border(side, width, colorNumber.color)
    }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func removeBorder(_ side: Borders.Side) -> Self {
        _borders.views[side]?.removeFromSuperview()
        _borders.views.removeValue(forKey: side)
        return self
    }
    
    // MARK: Alpha
    
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        declarativeView.alpha = alpha
        return self
    }
    
    // MARK: Opacity
    
    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
        declarativeView.layer.opacity = opacity
        return self
    }
    
    // MARK: Hidden
    
    @discardableResult
    public func hidden(_ hidden: Bool) -> Self {
        declarativeView.isHidden = hidden
        return self
    }
    
    // MARK: Layout
    
    func onLayoutSubviews() {
        if _circleCorners {
            if let minSide = [declarativeView.bounds.size.width, declarativeView.bounds.size.height].min() {
                declarativeView.layer.cornerRadius = minSide / 2
            }
        } else if let customCorners = _customCorners {
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
