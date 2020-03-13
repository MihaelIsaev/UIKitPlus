import UIKit

public protocol Colorable {
    @discardableResult
    func color(_ color: UIColor) -> Self
    
    @discardableResult
    func color(_ number: Int) -> Self
    
    @discardableResult
    func color(_ color: State<UIColor>) -> Self
    
    @discardableResult
    func color<V>(_ expressable: ExpressableState<V, UIColor>) -> Self
}

protocol _Colorable: Colorable {
    var _colorState: State<UIColor> { get }
    
    func _setColor(_ v: UIColor?)
}

extension Colorable {
    @discardableResult
    public func color(_ color: UIColor) -> Self {
        guard let s = self as? _Colorable else { return self }
        s._setColor(color)
        return self
    }
    
    @discardableResult
    public func color(_ number: Int) -> Self {
        color(number.color)
    }
    
    @discardableResult
    public func color(_ state: State<UIColor>) -> Self {
        state.listen { self.color($0) }
        return color(state.wrappedValue)
    }
    
    @discardableResult
    public func color<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        color(expressable.unwrap())
    }
}
