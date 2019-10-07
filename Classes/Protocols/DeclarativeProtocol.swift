import UIKit

public protocol DeclarativeProtocol: class {
    associatedtype V: UIView, DeclarativeProtocol = Self
    
    var declarativeView: V { get }
    var properties: Properties<V> { get set }
}
