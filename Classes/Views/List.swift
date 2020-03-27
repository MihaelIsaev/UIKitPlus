import UIKit

public typealias UList = List
public class List: View, UITableViewDataSource {
    @State var reversed = false
    
    var scrollPosition: State<CGPoint>?
    
    var listables: [Listable] = []
    
    public init (@ListableBuilder block: ListableBuilder.SingleView) {
        self.listables = block().listableBuilderItems
        super.init(frame: .zero)
        listables.enumerated().forEach { i, listable in
            if let l = listable as? ListableForEach {
                l.subscribeToChanges({ [weak self] in
                    self?.tableView.beginUpdates()
                }, { [weak self] deletions, insertions, modifications in
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: i)}, with: .automatic)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: i) }, with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: i) }, with: .automatic)
                }) { [weak self] in
                    self?.tableView.endUpdates()
                }
            }
        }
        $reversed.listen { [weak self] old, new in
            self?.tableView.transform = CGAffineTransform(rotationAngle: new ? -(CGFloat)(Double.pi) : 0)
            if let tableView = self?.tableView {
                tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 8)
            }
            if old != new {
                self?.tableView.reloadData()
            }
        }
        setup()
    }
    
    public init (@ListableBuilder block: (List) -> ListableBuilderItem) {
        super.init(frame: .zero)
        self.listables = block(self).listableBuilderItems
        listables.enumerated().forEach { i, listable in
            if let l = listable as? ListableForEach {
                l.subscribeToChanges({ [weak self] in
                    self?.tableView.beginUpdates()
                }, { [weak self] deletions, insertions, modifications in
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: i)}, with: .automatic)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: i) }, with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: i) }, with: .automatic)
                }) { [weak self] in
                    self?.tableView.endUpdates()
                }
            }
        }
        $reversed.listen { [weak self] old, new in
            self?.tableView.transform = CGAffineTransform(rotationAngle: new ? -(CGFloat)(Double.pi) : 0)
            if let tableView = self?.tableView {
                tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 8)
            }
            if old != new {
                self?.tableView.reloadData()
            }
        }
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Applies some defaults to the list
    public func setup() {
        tableView.separatorStyle(.none)
    }
    
    public lazy var tableView = TableView()
        .register(ListDynamicCell.self)
        .edgesToSuperview()
        .dataSource(self)
        .delegate(self)
        .background(backgroundColor ?? .clear)
    
    override public func buildView() {
        super.buildView()
        body {
            tableView
        }
    }
    
    // MARK: Keyboard Dismiss Mode
    
    @discardableResult
    public func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        tableView.keyboardDismissMode = mode
        return self
    }
    
    // MARK: ScrollView methods
    
    open func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        tableView.setContentOffset(contentOffset, animated: animated)
    }

    open func scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        tableView.scrollRectToVisible(rect, animated: animated)
    }
    
    // MARK: TableView methods
    
    open func reloadData() {
        tableView.reloadData()
    }
    
    open func reloadSection(_ i: Int) {
        tableView.reloadSections(IndexSet(integer: i), with: UITableView.RowAnimation.fade)
    }
    
    open func beginUpdates() {
        tableView.beginUpdates()
    }
    
    open func endUpdates() {
        tableView.endUpdates()
    }
    
    // MARK: - Refresh Control
    
    @discardableResult
    public func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        tableView.refreshControl(refreshControl)
        return self
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        listables.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listables[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ListDynamicCell.self, for: indexPath)
        let rootView = listables[indexPath.section].item(at: indexPath.row)
        cell.setRootView(rootView)
        cell.transform = CGAffineTransform(rotationAngle: reversed ? CGFloat(Double.pi) : 0)
        return cell
    }
    
    // MARK: - Separator
    
    @discardableResult
    public func separatorColor(_ value: UIColor) -> Self {
        tableView.separatorColor(value)
        return self
    }
    
    @discardableResult
    public func separatorStyle(_ value: UITableViewCell.SeparatorStyle) -> Self {
        tableView.separatorStyle(value)
        return self
    }
    
    @discardableResult
    public func separatorInset(_ value: UIEdgeInsets) -> Self {
        tableView.separatorInset(value)
        return self
    }
    
    @discardableResult
    public func separatorInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        tableView.separatorInset(top: top, left: left, right: right, bottom: bottom)
        return self
    }
    
    @discardableResult
    public func reversed(_ value: Bool = true) -> Self {
        reversed = value
        return self
    }
    
    @discardableResult
    public func update() -> Self {
        tableView.beginUpdates()
        tableView.endUpdates()
        return self
    }
}

extension List: UIScrollViewDelegate {
    @discardableResult
    public func contentOffset(_ position: CGPoint, animated: Bool = true) -> Self {
        tableView.setContentOffset(position, animated: animated)
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

extension List: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool { false }
}

extension List {
    // MARK: Indicators
    
    @discardableResult
    public func hideIndicator(_ indicators: NSLayoutConstraint.Axis...) -> Self {
        if indicators.contains(.horizontal) {
            tableView.showsHorizontalScrollIndicator = false
        }
        if indicators.contains(.vertical) {
            tableView.showsVerticalScrollIndicator = false
        }
        return self
    }
    
    // MARK: Indicators
    
    @discardableResult
    public func hideAllIndicators() -> Self {
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return self
    }
    
    // MARK: Content Inset
    
    @discardableResult
    public func contentInset(_ insets: UIEdgeInsets) -> Self {
        tableView.contentInset = insets
        return self
    }
    
    @discardableResult
    public func contentInset(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        contentInset(.init(top: top, left: left, bottom: bottom, right: right))
    }
    
    // MARK: Scroll Indicator Inset
    
    @discardableResult
    public func scrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
        tableView.scrollIndicatorInsets = insets
        return self
    }
    
    @discardableResult
    public func scrollIndicatorInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        scrollIndicatorInsets(.init(top: top, left: left, bottom: bottom, right: right))
    }
}
