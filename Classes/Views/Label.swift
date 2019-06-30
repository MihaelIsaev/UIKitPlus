//
//  UILabel.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 29/06/2019.
//

import UIKit

open class Label: UILabel, DeclarativeView {
    public var declarativeView: Label { return self }
    
    public var _circleCorners: Bool = false
    public var _customCorners: CustomCorners?
    public lazy var _borders = Borders()
    
    public init (_ text: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
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
    
    @discardableResult
    public func text(_ text: String) -> Label {
        self.text = text
        return self
    }
    
    @discardableResult
    public func color(_ color: UIColor) -> Label {
        textColor = color
        return self
    }
    
    @discardableResult
    public func color(_ number: Int) -> Label {
        textColor = number.color
        return self
    }
    
    @discardableResult
    public func font(v: UIFont?) -> Label {
        self.font = v
        return self
    }
    
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Label {
        return font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Label {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func center() -> Label {
        textAlignment = .center
        return self
    }
    
    @discardableResult
    public func lines(_ number: Int) -> Label {
        numberOfLines = number
        return self
    }
    
    @discardableResult
    public func multiline() -> Label {
        numberOfLines = 0
        return self
    }
}
