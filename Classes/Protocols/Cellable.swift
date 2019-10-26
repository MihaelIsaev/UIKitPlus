public protocol Cellable: class {}

extension Cellable {
    public static var reuseIdentifier: String { String(describing: self) }
}
