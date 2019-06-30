//
//  ScrollView.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 30/06/2019.
//

import UIKit

open class ScrollView: UIScrollView, DeclarativeView {
    public var declarativeView: ScrollView { return self }
    
    public var _circleCorners: Bool = false
    public var _customCorners: CustomCorners?
    public lazy var _borders = Borders()
    
    public init () {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
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
    
    // MARK: Paging
    
    @discardableResult
    public func paging(_ enabled: Bool) -> ScrollView {
        isPagingEnabled = enabled
        return self
    }
    
    // MARK: Scrolling
    
    @discardableResult
    public func scrolling(_ enabled: Bool) -> ScrollView {
        isScrollEnabled = enabled
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideIndicator(_ indicators: NSLayoutConstraint.Axis...) -> ScrollView {
        if indicators.contains(.horizontal) {
            showsHorizontalScrollIndicator = false
        }
        if indicators.contains(.vertical) {
            showsVerticalScrollIndicator = false
        }
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideAllIndicators() -> ScrollView {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        return self
    }
}
