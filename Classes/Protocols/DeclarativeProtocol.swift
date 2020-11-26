import UIKit

public protocol DeclarativeProtocol: class {
    associatedtype V: UIView, DeclarativeProtocol = Self
    
    var declarativeView: V { get }
    var properties: Properties<V> { get set }
    
    // MARK: Public Constraints
    
    var height: CGFloat { get set }
    var width: CGFloat { get set }
    var top: CGFloat { get set }
    var leading: CGFloat { get set }
    var left: CGFloat { get set }
    var trailing: CGFloat { get set }
    var right: CGFloat { get set }
    var bottom: CGFloat { get set }
    var centerX: CGFloat { get set }
    var centerY: CGFloat { get set }
}
protocol AnyDeclarativeProtocol: DeclarativeProtocol, Hiddenable {}

/// See `Hiddenable`
extension DeclarativeProtocol {
    var hiddenState: UState<Bool> { properties.hiddenState }
}
