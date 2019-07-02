import Foundation

internal protocol DeclarativeProtocolInternal: class {
    var _circleCorners: Bool { get set }
    var _customCorners: CustomCorners? { get set }
    var _borders: Borders { get }
    
    var _preConstraints: DeclarativePreConstraints { get set }
    var _constraints: DeclarativeConstraintsCollection { get set }
}
