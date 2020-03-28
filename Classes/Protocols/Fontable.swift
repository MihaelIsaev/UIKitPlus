import UIKit

public protocol Fontable {
    @discardableResult
    func font(v: UIFont?) -> Self
    
    @discardableResult
    func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self
}

protocol _Fontable: Fontable {
    func _setFont(_ v: UIFont?)
}

extension Fontable {
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        font(v: UIFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func font(_ binding: State<UIFont>) -> Self {
        binding.listen { self.font(v: $0) }
        return font(v: binding.wrappedValue)
    }
    
    @discardableResult
    public func font<V>(_ expressable: ExpressableState<V, UIFont>) -> Self {
        font(expressable.unwrap())
    }
}

@available(iOS 13.0, *)
extension Fontable {
    @discardableResult
    public func font(v: UIFont?) -> Self {
        guard let s = self as? _Fontable else { return self }
        s._setFont(v)
        return self
    }
}

// for iOS lower than 13
extension _Fontable {
    @discardableResult
    public func font(v: UIFont?) -> Self {
        _setFont(v)
        return self
    }
}

// MARK: Fontable at range

public protocol FontableAtRange {
    @discardableResult
    func font(v: UIFont?, at range: ClosedRange<Int>) -> Self
    
    @discardableResult
    func font(_ identifier: FontIdentifier, _ size: CGFloat, at range: ClosedRange<Int>) -> Self
}

protocol _FontableAtRange: _Fontable, FontableAtRange {}

extension FontableAtRange {
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat, at range: ClosedRange<Int>) -> Self {
        font(v: UIFont(name: identifier.fontName, size: size), at: range)
    }
}
