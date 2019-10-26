import Foundation

public protocol Listable {
    var count: Int { get }
    func item(at index: Int) -> VStack
}
