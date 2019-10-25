public protocol Identable: Hashable {
    associatedtype ID: Hashable
    
    typealias IDKey = KeyPath<Self, ID>
    
    static var idKey: IDKey { get }
}

extension Identable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self[keyPath: Self.idKey])
    }
}
