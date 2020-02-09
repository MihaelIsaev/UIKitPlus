import UIKit

public class Collection: View, UICollectionViewDataSource {
    @State
    var reversed = false
    
    var listables: [Listable]
    
    let layout: UICollectionViewLayout
    
    var scrollPosition: State<CGPoint>?
    
    public init (_ layout: UICollectionViewLayout = CollectionView.defaultLayout, @ListableBuilder block: ListableBuilder.SingleView) {
        self.layout = layout
        self.listables = block().listableBuilderItems
        super.init(frame: .zero)
        listables.enumerated().forEach { i, listable in
            if let l = listable as? ListableForEach {
                l.subscribeToChanges { [weak self] deletions, insertions, modifications in
                    self?.collectionView.performBatchUpdates({ [weak self] in
                        self?.collectionView.deleteItems(at: deletions.map { IndexPath(row: $0, section: i)})
                        self?.collectionView.insertItems(at: insertions.map { IndexPath(row: $0, section: i) })
                        self?.collectionView.reloadItems(at: modifications.map { IndexPath(row: $0, section: i) })
                    }, completion: nil)
                }
            }
        }
        $reversed.listen { [weak self] old, new in
            self?.collectionView.transform = CGAffineTransform(rotationAngle: new ? -(CGFloat)(Double.pi) : 0)
            if let collectionView = self?.collectionView {
                collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.bounds.size.width - 8)
            }
            if old != new {
                self?.collectionView.reloadData()
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView = CollectionView(layout)
        .register(CollectionDynamicCell.self)
        .edgesToSuperview()
        .dataSource(self)
        .delegate(self)
        .background(backgroundColor ?? .clear)
    
    override public func buildView() {
        super.buildView()
        body {
            collectionView
        }
    }
    
    // MARK: Keyboard Dismiss Mode
    
    @discardableResult
    public func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        collectionView.keyboardDismissMode = mode
        return self
    }
    
    // MARK: - Refresh Control
    
    @discardableResult
    public func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        collectionView.refreshControl(refreshControl)
        return self
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        listables.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listables[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CollectionDynamicCell.self, for: indexPath)
        let rootView = listables[indexPath.section].item(at: indexPath.row)
        cell.setRootView(rootView)
        cell.transform = CGAffineTransform(rotationAngle: reversed ? CGFloat(Double.pi) : 0)
        return cell
    }
    
    @discardableResult
    public func reversed(_ value: Bool = true) -> Self {
        reversed = value
        return self
    }
}

extension Collection: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool { false }
}

extension Collection: UIScrollViewDelegate {
    @discardableResult
    public func contentOffset(_ position: CGPoint, animated: Bool = true) -> Self {
        collectionView.setContentOffset(position, animated: animated)
        return self
    }
    
    @discardableResult
    public func scrollPosition(_ binding: UIKitPlus.State<CGPoint>) -> Self {
        scrollPosition = binding
        return self
    }
    
    @discardableResult
    public func scrollPosition<V>(_ expressable: ExpressableState<V, CGPoint>) -> Self {
        scrollPosition = expressable.unwrap()
        return self
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollPosition?.wrappedValue = scrollView.contentOffset
    }
}

extension Collection {
    // MARK: Indicators
    
    @discardableResult
    public func hideIndicator(_ indicators: NSLayoutConstraint.Axis...) -> Self {
        if indicators.contains(.horizontal) {
            collectionView.showsHorizontalScrollIndicator = false
        }
        if indicators.contains(.vertical) {
            collectionView.showsVerticalScrollIndicator = false
        }
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideAllIndicators() -> Self {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return self
    }
    
    // MARK: Content Inset
    
    @discardableResult
    public func contentInset(_ insets: UIEdgeInsets) -> Self {
        collectionView.contentInset = insets
        return self
    }
    
    @discardableResult
    public func contentInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        contentInset(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    // MARK: Scroll Indicator Inset
    
    @discardableResult
    public func scrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
        collectionView.scrollIndicatorInsets = insets
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        scrollIndicatorInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
}

