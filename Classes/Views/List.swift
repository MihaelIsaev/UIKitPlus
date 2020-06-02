import UIKit

class ListSection {
    var item: ViewBuilderItem
    let axis: NSLayoutConstraint.Axis
    
    init (_ item: ViewBuilderItem, axis: NSLayoutConstraint.Axis? = nil) {
        self.item = item
        self.axis = axis ?? .vertical
    }
}

public typealias UList = List
public class List: View, UITableViewDataSource {
    @State var reversed = false
    
    var scrollPosition: State<CGPoint>?
    
    var items: [ListSection] = []
    
    public override init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        process(block())
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
    
    public init (@ViewBuilder block: (List) -> ViewBuilder.Result) {
        super.init(frame: .zero)
        process(block(self))
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
    
    func process(_ item: ViewBuilderItemable, sectionIndex: Int = 0) {
        let item = item.viewBuilderItem
        switch item {
        case .single(let view):
            handleHiddency(view, at: sectionIndex)
            items.append(.init(item))
        case .multiple(let views):
            views.forEach { handleHiddency($0, at: sectionIndex) }
            items.append(.init(item))
        case .forEach(let fr):
            let direction = fr.axis ?? .vertical
            let listSection = ListSection(item, axis: direction)
            items.append(listSection)
            fr.subscribeToChanges({ [weak self] in
                self?.tableView.beginUpdates()
            }, { [weak self] deletions, insertions, modifications in
                self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: sectionIndex)}, with: .automatic)
                self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: sectionIndex) }, with: .automatic)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: sectionIndex) }, with: .automatic)
            }) { [weak self] in
                self?.tableView.endUpdates()
            }
        case .nested(let items):
            items.enumerated().forEach { i, v in
                process(v, sectionIndex: sectionIndex + i)
            }
        case .none:
            break
        }
    }
    
    private func handleHiddency(_ view: UIView, at sectionIndex: Int) {
        if let v = view as? Hiddenable {
            var isVisibleInList = !v.hiddenState.wrappedValue
            v.hiddenState.beginTrigger { [weak self] in
                self?.tableView.beginUpdates()
            }
            v.hiddenState.listen { [weak self] old, new in
                guard old != new else { return }
                switch new {
                case true:
                   guard isVisibleInList else { return }
                   isVisibleInList = false
                    self?.tableView.deleteRows(at: [0].map { IndexPath(row: $0, section: sectionIndex)}, with: .automatic)
                case false:
                   guard !isVisibleInList else { return }
                   isVisibleInList = true
                   self?.tableView.insertRows(at: [0].map { IndexPath(row: $0, section: sectionIndex) }, with: .automatic)
                }
            }
            v.hiddenState.endTrigger { [weak self] in
                self?.tableView.endUpdates()
            }
        }
    }
    
    /// Applies some defaults to the list
    public func setup() {
        tableView.separatorStyle(.none)
    }
    
    public lazy var tableView = TableView()
        .register(ListDynamicCell.self)
        .automaticDimension()
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
        items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch items[section].item {
        case .single(let view):
            return view.isHidden ? 0 : 1
        case .multiple(let views):
            return views.filter { !$0.isHidden }.count
        case .forEach(let fr):
            return fr.count
        case .nested, .none:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ListDynamicCell.self, for: indexPath)
        let section = items[indexPath.section]
        switch section.item {
        case .single(let view):
            cell.setRootViews(view)
        case .multiple(let views):
            cell.setRootViews(views.filter { !$0.isHidden }[indexPath.row])
        case .forEach(let fr):
            let item = fr.items(at: indexPath.row).viewBuilderItem
            switch item {
            case .single(let view):
                cell.setRootViews(view)
            case .multiple(let views):
                cell.setRootViews(views)
            case .forEach(let fr):
                if fr.axis != nil {
                    cell.setRootViews(StackView(ViewBuilderItems(items: fr.allItems())).axis(section.axis))
                } else {
                    cell.contentView.subviews.forEach {  $0.removeFromSuperview() }
                    cell.contentView.addItem(section.item)
                }
            case .nested(let items):
                cell.setRootViews([StackView(ViewBuilderItems(items: items)).axis(section.axis).edgesToSuperview()])
            case .none:
                cell.setRootViews(View())
            }
        case .nested, .none:
            cell.setRootViews(View())
        }
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
