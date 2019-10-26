import Foundation

public class ForEach<Item>: Listable, ListableForEach, ListableBuilderItem, ViewBuilderItem where Item: Hashable {
    public typealias BuildViewHandler = (Int, Item) -> ViewBuilderItem
    public typealias BuildViewHandlerValue = (Item) -> ViewBuilderItem
    public typealias BuildViewHandlerSimple = () -> ViewBuilderItem
    
    let items: State<[Item]>
    let block: BuildViewHandler
    
    public init (_ items: [Item], @ViewBuilder block: @escaping BuildViewHandler) {
        self.items = State(initialValue: items)
        self.block = block
    }
    
    public init (_ items: [Item], @ViewBuilder block: @escaping BuildViewHandlerValue) {
        self.items = State(initialValue: items)
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: [Item], @ViewBuilder block: @escaping BuildViewHandlerSimple) {
        self.items = State(initialValue: items)
        self.block = { _,_ in
            block()
        }
    }
    
    public init (_ items: State<[Item]>, @ViewBuilder block: @escaping BuildViewHandler) {
        self.items = items
        self.block = block
    }
    
    public init (_ items: State<[Item]>, @ViewBuilder block: @escaping BuildViewHandlerValue) {
        self.items = items
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: State<[Item]>, @ViewBuilder block: @escaping BuildViewHandlerSimple) {
        self.items = items
        self.block = { _,_ in
            block()
        }
    }
    
    // MARK: Listable
    
    public var count: Int { items.wrappedValue.count }
    
    public func item(at index: Int) -> VStack {
        guard index < items.wrappedValue.count else { return VStack() }
        let rawViews = block(index, items.wrappedValue[index]).viewBuilderItems
        return VStack { rawViews.map { View(inline: $0) } }
    }
    
    // MARK: ListableForEach
    
    func subscribeToChanges(_ handler: @escaping ([Int], [Int], [Int]) -> Void) {
        items.listen { old, new in
            let diff = old.difference(new)
            let deletions = diff.removed.compactMap { $0.index }
            let insertions = diff.inserted.compactMap { $0.index }
            let modifications = diff.modified.compactMap { $0.index }
            guard deletions.count > 0 || insertions.count > 0 || modifications.count > 0 else { return }
            handler(deletions, insertions, modifications)
        }
    }
    
    // MARK: ListableBuilderItem
    
    public var listableBuilderItems: [Listable] { [self] }
    
    // MARK: ViewBuilderItem
    
    public var viewBuilderItems: [UIView] {
        items.wrappedValue.enumerated().map { item(at: $0.offset) }
    }
}

extension ForEach where Item == Int {
    public convenience init (_ items: ClosedRange<Item>, @ViewBuilder block: @escaping BuildViewHandler) {
        self.init(items.map { $0 }, block: block)
    }
    
    public convenience init (_ items: ClosedRange<Item>, @ViewBuilder block: @escaping BuildViewHandlerValue) {
        self.init(items.map { $0 }, block: block)
    }
    
    public convenience init (_ items: ClosedRange<Item>, @ViewBuilder block: @escaping BuildViewHandlerSimple) {
        self.init(items.map { $0 }, block: block)
    }
}
