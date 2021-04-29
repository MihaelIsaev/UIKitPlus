public protocol Cellable: AnyObject {}

extension Cellable {
    public static var reuseIdentifier: String { String(describing: self) }
}
