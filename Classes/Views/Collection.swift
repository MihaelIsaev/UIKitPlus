import UIKit

class CollectionSection {
    var item: ViewBuilderItem
    let axis: NSLayoutConstraint.Axis
    
    init (_ item: ViewBuilderItem, axis: NSLayoutConstraint.Axis? = nil) {
        self.item = item
        self.axis = axis ?? .vertical
    }
}

public typealias Collection = UCollection
public class UCollection: View, UICollectionViewDataSource {
    @State var reversed = false
    
    var items: [CollectionSection] = []
    
    let layout: UICollectionViewLayout
    
    var scrollPosition: State<CGPoint>?
    
    class SectionChanges {
        let section: Int
        var deletions: Set<Int> = []
        var insertions: Set<Int> = []
        var modifications: Set<Int> = []
        
        init (section: Int) {
            self.section = section
        }
    }
    
    var changesPool: [SectionChanges] = []
    var isChanging = false
    
    func applyChanges(_ changes: SectionChanges) {
        if isChanging {
            changesPool.append(changes)
            return
        }
        isChanging = true
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: changes.deletions.map { IndexPath(row: $0, section: changes.section)})
            collectionView.insertItems(at: changes.insertions.map { IndexPath(row: $0, section: changes.section) })
            collectionView.reloadItems(at: changes.modifications.map { IndexPath(row: $0, section: changes.section) })
        }) { _ in
            self.isChanging = false
            if self.changesPool.count > 0 {
                self.applyChanges(self.changesPool.removeFirst())
            }
        }
    }
    
    public init (_ layout: UICollectionViewLayout = CollectionView.defaultLayout, @ViewBuilder block: ViewBuilder.SingleView) {
        self.layout = layout
        super.init(frame: .zero)
        process(block())
        collectionView.reloadData()
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
    
    func process(_ item: ViewBuilderItemable, sectionIndex: Int = 0) {
        let item = item.viewBuilderItem
        switch item {
        case .single:
            items.append(.init(item))
        case .multiple:
            items.append(.init(item))
        case .forEach(let fr):
            var direction: NSLayoutConstraint.Axis? = nil
            if let axis = fr.axis {
                direction = axis
            } else if let fl = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                direction = fl.scrollDirection == .horizontal ? .horizontal : .vertical
            }
            let collectionSection = CollectionSection(item, axis: direction)
            items.append(collectionSection)
            let changes = SectionChanges(section: sectionIndex)
            fr.subscribeToChanges({
                changes.deletions.removeAll()
                changes.insertions.removeAll()
                changes.modifications.removeAll()
            }, { d, i, m in
                d.forEach { changes.deletions.insert($0) }
                i.forEach { changes.insertions.insert($0) }
                m.forEach { changes.modifications.insert($0) }
            }) { [weak self] in
                self?.applyChanges(changes)
            }
        case .nested(let items):
            items.enumerated().forEach { i, v in
                process(v, sectionIndex: sectionIndex + i)
            }
        case .none:
            break
        }
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
    #if os(iOS)
    @discardableResult
    public func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        collectionView.refreshControl(refreshControl)
        return self
    }
    #endif
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch items[section].item {
        case .single:
            return 1
        case .multiple(let views):
            return views.count
        case .forEach(let fr):
            return fr.count
        case .nested, .none:
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CollectionDynamicCell.self, for: indexPath)
        let section = items[indexPath.section]
        switch section.item {
        case .single(let view):
            cell.setRootView(StackView(view).axis(section.axis))
        case .multiple(let views):
            cell.setRootView(StackView(views).axis(section.axis))
        case .forEach(let fr):
            let item = fr.items(at: indexPath.row).viewBuilderItem
            switch item {
            case .single(let view):
                cell.setRootView(StackView(view).axis(section.axis))
            case .multiple(let views):
                cell.setRootView(StackView(views).axis(section.axis))
            case .forEach(let fr):
                cell.setRootView(StackView(ViewBuilderItems(items: fr.allItems())).axis(section.axis))
            case .nested(let items):
                cell.setRootView(StackView(ViewBuilderItems(items: items)).axis(section.axis))
            case .none:
                cell.setRootView(.init())
            }
        case .nested, .none:
            cell.setRootView(.init())
        }
        cell.transform = CGAffineTransform(rotationAngle: reversed ? CGFloat(Double.pi) : 0)
        return cell
    }
    
    @discardableResult
    public func reversed(_ value: Bool = true) -> Self {
        reversed = value
        return self
    }
    
    @discardableResult
    public func alwaysBounceVertical(_ value: Bool = true) -> Self {
        collectionView.alwaysBounceVertical = value
        return self
    }
    
    // MARK: Delegate
    
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.collectionView.delegate = delegate
        return self
    }
}

extension UCollection: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool { false }
}

extension UCollection: UIScrollViewDelegate {
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

extension UCollection {
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

