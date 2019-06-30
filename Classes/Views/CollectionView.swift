//
//  CollectionView.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 30/06/2019.
//

import UIKit

open class CollectionView: UICollectionView, DeclarativeView {
    public var declarativeView: CollectionView { return self }
    
    public var _circleCorners: Bool = false
    public var _customCorners: CustomCorners?
    public lazy var _borders = Borders()
    
    public init (_ layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
    public func paging(_ enabled: Bool) -> CollectionView {
        isPagingEnabled = enabled
        return self
    }
}
