import UIKit

internal protocol DeclarativeProtocolInternal: class {
    var _properties: PropertiesInternal { get set }
    
    var __height: UState<CGFloat> { get }
    var __width: UState<CGFloat> { get }
    var __top: UState<CGFloat> { get }
    var __leading: UState<CGFloat> { get }
    var __left: UState<CGFloat> { get }
    var __trailing: UState<CGFloat> { get }
    var __right: UState<CGFloat> { get }
    var __bottom: UState<CGFloat> { get }
    var __centerX: UState<CGFloat> { get }
    var __centerY: UState<CGFloat> { get }
}
