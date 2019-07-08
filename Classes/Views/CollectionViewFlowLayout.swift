import UIKit

public class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    public override init () {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func itemSize(_ size: CGSize) -> Self {
        itemSize = size
        return self
    }
    
    @discardableResult
    public func itemSize(_ width: CGFloat, _ height: CGFloat) -> Self {
        itemSize = .init(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func itemSize(_ size: CGFloat) -> Self {
        itemSize = .init(width: size, height: size)
        return self
    }
    
    @discardableResult
    public func estimatedItemSize(_ size: CGSize) -> Self {
        estimatedItemSize = size
        return self
    }
    
    @discardableResult
    public func estimatedItemSize(_ width: CGFloat, _ height: CGFloat) -> Self {
        estimatedItemSize = .init(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func estimatedItemSize(_ size: CGFloat) -> Self {
        estimatedItemSize = .init(width: size, height: size)
        return self
    }
    
    @discardableResult
    public func minimumInteritemSpacing(_ value: CGFloat) -> Self {
        minimumInteritemSpacing = value
        
        return self
    }
    
    @discardableResult
    public func minimumLineSpacing(_ value: CGFloat) -> Self {
        minimumLineSpacing = value
        return self
    }
    
    @discardableResult
    public func scrollDirection(_ direction: UICollectionView.ScrollDirection) -> Self {
        scrollDirection = direction
        return self
    }
}
