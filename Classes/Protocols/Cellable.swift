public protocol Cellable: class {}

extension Cellable {
    public static var reuseIdentifier: String { return String(describing: self) }
}
