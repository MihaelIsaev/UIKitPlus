import UIKit

open class StaticList: View {
    @State var views: [UIView] = []
    
    public override init (@ViewBuilder block: ViewBuilder.SingleView) {
        views = block().viewBuilderItems
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView = TableView()
        .background(.white)
        .edgesToSuperview()
        .dataSource(self)
        .delegate(self)
    
    override open func buildView() {
        super.buildView()
        body {
            tableView
        }
        $views.listen { [weak self] old, new in
            let diff = old.difference(new)
            let deletions = diff.removed.compactMap { $0.index }
            let insertions = diff.inserted.compactMap { $0.index }
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
            self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
//            tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
            self?.tableView.endUpdates()
        }
        tableView.reloadData()
    }
    
    public func append(_ view: UIView) {
        views.append(view)
    }
    
    public func remove(_ view: UIView) {
        views.removeAll(where: { $0 === view })
    }
    
    public func removeAll() {
        views.removeAll()
    }
    
    public func removeFirst() {
        views.removeFirst()
    }
    
    public func removeLast() {
        views.removeLast()
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
}

extension StaticList: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return views.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return StaticListCell(views[indexPath.row])
    }
}

extension StaticList: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let view = views[indexPath.row] as? View {
            view._tap()
        } else if let view = views[indexPath.row] as? Button {
            view.tapEvent()
            view.tapEvenWithButton(view)
        }
    }
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

class StaticListCell: TableViewCell {
    init (_ rootView: UIView) {
        super.init(style: .default, reuseIdentifier: nil)
        addSubview(rootView)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            topAnchor.constraint(equalTo: rootView.topAnchor),
            bottomAnchor.constraint(equalTo: rootView.bottomAnchor)
        ])
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
