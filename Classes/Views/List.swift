import UIKit

public class List: View, UITableViewDataSource {
    @State
    var reversed = false
    
    var listables: [Listable] = []
    
    public init (@ListableBuilder block: ListableBuilder.SingleView) {
        self.listables = block().listableBuilderItems
        super.init(frame: .zero)
        listables.enumerated().forEach { i, listable in
            if let l = listable as? ListableForEach {
                l.subscribeToChanges { [weak self] deletions, insertions, modifications in
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: i)}, with: .automatic)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: i) }, with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: i) }, with: .automatic)
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
                l.subscribeToChanges { [weak self] deletions, insertions, modifications in
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: i)}, with: .automatic)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: i) }, with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: i) }, with: .automatic)
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
    
    lazy var tableView = TableView()
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

extension List: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
