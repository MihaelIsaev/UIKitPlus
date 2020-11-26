import Foundation



class SortedMerge {
    
    static let shared: SortedMerge = {
        let instance = SortedMerge()
        return instance
    }()
    
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
    
    public func sortedMerge<LeftSequence: Sequence, RightSequence: Sequence, Key: Comparable>(
        left lSeq: LeftSequence,
        right rSeq: RightSequence,
        leftKey: @escaping (LeftSequence.Element) -> Key,
        rightKey: @escaping (RightSequence.Element) -> Key) -> AnySequence<MergeStep<LeftSequence.Element, RightSequence.Element>>
    {
        return AnySequence { () -> AnyIterator<MergeStep<LeftSequence.Element, RightSequence.Element>> in
            var (lGen, rGen) = (lSeq.makeIterator(), rSeq.makeIterator())
            var (lOpt, rOpt) = (lGen.next(), rGen.next())
            return AnyIterator {
                switch (lOpt, rOpt) {
                case (let lElem?, let rElem?):
                    let (lKey, rKey) = (leftKey(lElem), rightKey(rElem))
                    if lKey > rKey {
                        rOpt = rGen.next()
                        return .right(rElem)
                    } else if lKey == rKey {
                        (lOpt, rOpt) = (lGen.next(), rGen.next())
                        return .common(lElem, rElem)
                    } else {
                        lOpt = lGen.next()
                        return .left(lElem)
                    }
                case (nil, let rElem?):
                    rOpt = rGen.next()
                    return .right(rElem)
                case (let lElem?, nil):
                    lOpt = lGen.next()
                    return .left(lElem)
                case (nil, nil):
                    return nil
                }
            }
        }
    }
    
    public enum MergeStep<LeftElement, RightElement> {
        /// An element only found in the left sequence:
        case left(LeftElement)
        /// An element only found in the right sequence:
        case right(RightElement)
        /// Left and right elements share a common key:
        case common(LeftElement, RightElement)
    }
    
}

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
        var inserted2idx = 0
        var idx = 0
        var inserted: [DiffItem<T2>] = []
        var removed: [DiffItem<T1>] = []
        
        let combinations = first.compactMap { a in (a, second.first { b in compare(a.hashValue, b.hashValue) }) }
        let common = combinations.filter { $0.1 != nil }.compactMap { ($0.0, $0.1!) }
        
        for mergeStep in SortedMerge.shared.sortedMerge (
            left: first,
            right: second,
            leftKey: { $0.hashValue },
            rightKey: { $0.hashValue })
        {
            switch mergeStep {
            case .left(let item):
                //print("LEFT (DELETE): \(item)")
                if  let index = first.firstIndex(where: { $0.hashValue == item.hashValue }) {
                    removed.append(DiffItem(index: index, value: item))
                    //inserted2idx += 1
                }
                break
            case .right(let item):
                //print("RIGHT (INSERT): \(item)")
                if  let index = second.firstIndex(where: { $0.hashValue == item.hashValue }) {
                    inserted.append(DiffItem(index: index, value: item))
                    inserted2idx += 1
                }
                break
            case .common(let item1, let item2):
                //print("COMMON (MODIFIED ?): \(item1) - \(item2)")
                break
            }
            idx += 1
        }
        
        //print("--------------------------------------------------------------------------------------------------")
        //inserted2.forEach( { print("inserted2: \($0)") } )
        //removed2.forEach( { print("removed2: \($0)") } )
        //print("--------------------------------------------------------------------------------------------------")
        
        let modified: [DiffItem<T2>] = [] // TODO: ?
        
        return DiffResult(common: common, removed: removed, inserted: inserted, modified: modified)
    }
    
    public func differenceOld<T1: Hashable, T2: Hashable>(_ first: [T1], _ second: [T2], with compare: (Int,Int) -> Bool) -> DiffResult<T1, T2> {
        print("10 - \(Date())")
        let combinations = first.compactMap { a in (a, second.first { b in compare(a.hashValue, b.hashValue) }) }
        let common = combinations.filter { $0.1 != nil }.compactMap { ($0.0, $0.1!) }
        print("20 - \(Date())")
        let removed: [DiffItem<T1>] = combinations.filter { $0.1 == nil }.compactMap { a,_ in
            guard let index = first.firstIndex(where: { $0.hashValue == a.hashValue }) else { return nil }
            return DiffItem(index: index, value: a)
        }
        print("30 - \(Date())")
        let inserted: [DiffItem<T2>] = second.filter { b in
            !common.contains { compare($0.0.hashValue, b.hashValue) }
        }.compactMap { b in
            guard let index = second.firstIndex(where: { $0.hashValue == b.hashValue }) else { return nil }
            return DiffItem(index: index, value: b)
        }
        let modified: [DiffItem<T2>] = [] // TODO: ?
        print("40 - \(Date())")
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
        difference(self, new, with: ==)
    }
}
