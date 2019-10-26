import Foundation

internal protocol DeclarativeProtocolInternal: class {
    var _properties: PropertiesInternal { get set }
}
