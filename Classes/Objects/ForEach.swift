import UIKit

public protocol AnyForEach {
    var axis: NSLayoutConstraint.Axis? { get }
    var count: Int { get }
    func allItems() -> [ViewBuilder.Result]
    func items(at index: Int) -> ViewBuilder.Result
    func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping ([Int], [Int], [Int]) -> Void, _ end: @escaping () -> Void)
}

public typealias UForEach = ForEach
public class ForEach<Item> where Item: Hashable {
    public typealias BuildViewHandler = (Int, Item) -> ViewBuilder.Result
    public typealias BuildViewHandlerValue = (Item) -> ViewBuilder.Result
    public typealias BuildViewHandlerSimple = () -> ViewBuilder.Result
    
    let items: State<[Item]>
    let block: BuildViewHandler
    
    public var axis: NSLayoutConstraint.Axis? { nil }
    
    public init (_ items: [Item], @ViewBuilder block: @escaping BuildViewHandler) {
        self.items = State(wrappedValue: items)
        self.block = block
    }
    
    public init (_ items: [Item], @ViewBuilder block: @escaping BuildViewHandlerValue) {
        self.items = State(wrappedValue: items)
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: [Item], @ViewBuilder block: @escaping BuildViewHandlerSimple) {
        self.items = State(wrappedValue: items)
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
}

extension ForEach: AnyForEach {
    public var count: Int { items.wrappedValue.count }
    
    public func allItems() -> [ViewBuilder.Result] {
        items.wrappedValue.enumerated().map {
            block($0.offset, $0.element)
        }
    }
    
    public func items(at index: Int) -> ViewBuilder.Result {
        guard index < items.wrappedValue.count else { return [] }
        return block(index, items.wrappedValue[index])
    }
    
    public func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping ([Int], [Int], [Int]) -> Void, _ end: @escaping () -> Void) {
        items.beginTrigger(begin)
        items.listen { old, new in
            let diff = old.difference(new)
            let deletions = diff.removed.compactMap { $0.index }
            let insertions = diff.inserted.compactMap { $0.index }
            let modifications = diff.modified.compactMap { $0.index }
            guard deletions.count > 0 || insertions.count > 0 || modifications.count > 0 else { return }
            handler(deletions, insertions, modifications)
        }
        items.endTrigger(end)
    }
}

extension ForEach: ViewBuilderItemable {
    public var viewBuilderItem: ViewBuilderItem {
        .forEach(self)
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

public class VForEach<Item>: ForEach<Item> where Item: Hashable {
    public override var axis: NSLayoutConstraint.Axis? { .vertical }
}

public class HForEach<Item>: ForEach<Item> where Item: Hashable {
    public override var axis: NSLayoutConstraint.Axis? { .horizontal }
}
