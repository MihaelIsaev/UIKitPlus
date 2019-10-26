import Foundation

internal protocol DeclarativeProtocolInternal: class {
    var _properties: PropertiesInternal { get set }
    
    var __height: State<CGFloat> { get }
    var __width: State<CGFloat> { get }
    var __top: State<CGFloat> { get }
    var __leading: State<CGFloat> { get }
    var __left: State<CGFloat> { get }
    var __trailing: State<CGFloat> { get }
    var __right: State<CGFloat> { get }
    var __bottom: State<CGFloat> { get }
    var __centerX: State<CGFloat> { get }
    var __centerY: State<CGFloat> { get }
}
