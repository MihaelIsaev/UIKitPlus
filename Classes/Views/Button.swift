//
//  Button.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 29/06/2019.
//

import UIKit

open class Button: UIButton, DeclarativeView {
    public var declarativeView: Button { return self }
    
    public var _circleCorners: Bool = false
    public var _customCorners: CustomCorners?
    public lazy var _borders = Borders()
    
    public init (_ title: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    // MARK: Title
    
    @discardableResult
    public func title(_ title: String, _ state: UIControl.State = .normal) -> Button {
        setTitle(title, for: state)
        return self
    }
    
    // MARK: Title Color
    
    @discardableResult
    public func color(_ color: UIColor, _ state: UIControl.State = .normal) -> Button {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func color(_ number: Int, _ state: UIControl.State = .normal) -> Button {
        setTitleColor(number.color, for: state)
        return self
    }
    
    // MARK: Title Font
    
    @discardableResult
    public func font(v: UIFont?) -> Button {
        titleLabel?.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Button {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    // MARK: Image
    
    @discardableResult
    public func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Button {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func image(_ imageName: String, _ state: UIControl.State = .normal) -> Button {
        setImage(UIImage(named: imageName), for: state)
        return self
    }
    
    // MARK: TouchUpInside
    
    public typealias BackAction = ()->Void
    
    private var tapCallback: BackAction?
    
    @discardableResult
    public func onTap(_ callback: BackAction?) -> Button {
        tapCallback = callback
        addTarget(self, action: #selector(tapEvent), for: .touchUpInside)
        return self
    }
    
    @objc private func tapEvent() {
        tapCallback?()
    }
}
