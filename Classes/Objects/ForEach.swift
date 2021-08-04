#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol AnyForEach {
    #if os(macOS)
    var orientation: NSUserInterfaceLayoutOrientation? { get }
    #else
    var axis: NSLayoutConstraint.Axis? { get }
    #endif
    var count: Int { get }
    func allItems() -> [BodyBuilder.Result]
    func items(at index: Int) -> BodyBuilder.Result
    func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping ([Int], [Int], [Int]) -> Void, _ end: @escaping () -> Void)
}

public typealias UForEach = ForEach
public class ForEach<Item> where Item: Hashable {
    public typealias BuildViewHandler = (Int, Item) -> BodyBuilder.Result
    public typealias BuildViewHandlerValue = (Item) -> BodyBuilder.Result
    public typealias BuildViewHandlerSimple = () -> BodyBuilder.Result
    
    let items: State<[Item]>
    let block: BuildViewHandler
    
    #if os(macOS)
    public var orientation: NSUserInterfaceLayoutOrientation? { nil }
    #else
    public var axis: NSLayoutConstraint.Axis? { nil }
    #endif
    
    public init (_ items: [Item], @BodyBuilder block: @escaping BuildViewHandler) {
        self.items = State(wrappedValue: items)
        self.block = block
    }
    
    public init (_ items: [Item], @BodyBuilder block: @escaping BuildViewHandlerValue) {
        self.items = State(wrappedValue: items)
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: [Item], @BodyBuilder block: @escaping BuildViewHandlerSimple) {
        self.items = State(wrappedValue: items)
        self.block = { _,_ in
            block()
        }
    }
    
    public init (_ items: State<[Item]>, @BodyBuilder block: @escaping BuildViewHandler) {
        self.items = items
        self.block = block
    }
    
    public init (_ items: State<[Item]>, @BodyBuilder block: @escaping BuildViewHandlerValue) {
        self.items = items
        self.block = { _, v in
            block(v)
        }
    }
    
    public init (_ items: State<[Item]>, @BodyBuilder block: @escaping BuildViewHandlerSimple) {
        self.items = items
        self.block = { _,_ in
            block()
        }
    }
}

extension ForEach: AnyForEach {
    public var count: Int { items.wrappedValue.count }
    
    public func allItems() -> [BodyBuilder.Result] {
        items.wrappedValue.enumerated().compactMap { [weak self] in
            self?.block($0.offset, $0.element)
        }
    }
    
    public func items(at index: Int) -> BodyBuilder.Result {
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

extension ForEach: BodyBuilderItemable {
    public var bodyBuilderItem: BodyBuilderItem {
        .forEach(self)
    }
}

extension ForEach where Item == Int {
    public convenience init (_ items: ClosedRange<Item>, @BodyBuilder block: @escaping BuildViewHandler) {
        self.init(items.map { $0 }, block: block)
    }
    
    public convenience init (_ items: ClosedRange<Item>, @BodyBuilder block: @escaping BuildViewHandlerValue) {
        self.init(items.map { $0 }, block: block)
    }
    
    public convenience init (_ items: ClosedRange<Item>, @BodyBuilder block: @escaping BuildViewHandlerSimple) {
        self.init(items.map { $0 }, block: block)
    }
}

public class VForEach<Item>: ForEach<Item> where Item: Hashable {
    #if os(macOS)
    public override var orientation: NSUserInterfaceLayoutOrientation? { .horizontal }
    #else
    public override var axis: NSLayoutConstraint.Axis? { .vertical }
    #endif
}

public class HForEach<Item>: ForEach<Item> where Item: Hashable {
    #if os(macOS)
    public override var orientation: NSUserInterfaceLayoutOrientation? { .horizontal }
    #else
    public override var axis: NSLayoutConstraint.Axis? { .horizontal }
    #endif
}
