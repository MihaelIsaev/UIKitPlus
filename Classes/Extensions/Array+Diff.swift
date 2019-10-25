import Foundation

extension Array {
    public struct DiffItem<V> {
        public let index: Int
        public let value: V
    }
    public struct DiffResult<T1, T2> {
        public let common: [(old: T1, new: T2)]
        public let removed: [DiffItem<T1>]
        public let inserted: [DiffItem<T2>]
        public let modified: [DiffItem<T2>]
        public init(common: [(T1, T2)] = [], removed: [DiffItem<T1>] = [], inserted: [DiffItem<T2>] = [], modified: [DiffItem<T2>] = []) {
            self.common = common
            self.removed = removed
            self.inserted = inserted
            self.modified = modified
        }
    }
    public func difference<T1: Hashable, T2: Hashable>(_ first: [T1], _ second: [T2], with compare: (Int,Int) -> Bool) -> DiffResult<T1, T2> {
        let combinations = first.compactMap { a in (a, second.first { b in compare(a.hashValue, b.hashValue) }) }
        let common = combinations.filter { $0.1 != nil }.compactMap { ($0.0, $0.1!) }
        var removed: [DiffItem<T1>] = combinations.filter { $0.1 == nil }.compactMap { a,_ in
            guard let index = first.firstIndex(where: { $0.hashValue == a.hashValue }) else { return nil }
            return DiffItem(index: index, value: a)
        }
        var inserted: [DiffItem<T2>] = second.filter { b in
            !common.contains { compare($0.0.hashValue, b.hashValue) }
        }.compactMap { b in
            guard let index = second.firstIndex(where: { $0.hashValue == b.hashValue }) else { return nil }
            return DiffItem(index: index, value: b)
        }
        var modified: [DiffItem<T2>] = [] // TODO: ?
//        print("1 removed: \(removed), inserted: \(inserted), modified: \(modified)   a.count: \(first.count)  b.count: \(second.count)")
//        if inserted.count > 0, first.count - removed.count == second.count {
//            modified = inserted
//            inserted = []
//        }
//        print("2 removed: \(removed), inserted: \(inserted), modified: \(modified)")
        return DiffResult(common: common, removed: removed, inserted: inserted, modified: modified)
    }
}
extension Array where Element: Hashable {
    public func difference<T2: Hashable>(_ new: [T2]) -> DiffResult<Element, T2> {
        return difference(self, new, with: ==)
    }
}
