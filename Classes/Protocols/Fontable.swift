#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Fontable: class {
    @discardableResult
    func font(v: UFont?) -> Self
    
    @discardableResult
    func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self
}

protocol _Fontable: Fontable {
    func _setFont(_ v: UFont?)
}

extension Fontable {
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat) -> Self {
        font(v: UFont(name: identifier.fontName, size: size))
    }
    
    @discardableResult
    public func font(_ binding: State<UFont>) -> Self {
        binding.listen { [weak self] in
            self?.font(v: $0)
        }
        return font(v: binding.wrappedValue)
    }
}

@available(iOS 13.0, *)
extension Fontable {
    @discardableResult
    public func font(v: UFont?) -> Self {
        guard let s = self as? _Fontable else { return self }
        s._setFont(v)
        return self
    }
}

// for iOS lower than 13
extension _Fontable {
    @discardableResult
    public func font(v: UFont?) -> Self {
        _setFont(v)
        return self
    }
}

// MARK: Fontable at range

public protocol FontableAtRange {
    @discardableResult
    func font(v: UFont?, at range: ClosedRange<Int>) -> Self
    
    @discardableResult
    func font(_ identifier: FontIdentifier, _ size: CGFloat, at range: ClosedRange<Int>) -> Self
}

protocol _FontableAtRange: _Fontable, FontableAtRange {}

extension FontableAtRange {
    @discardableResult
    public func font(_ identifier: FontIdentifier, _ size: CGFloat, at range: ClosedRange<Int>) -> Self {
        font(v: UFont(name: identifier.fontName, size: size), at: range)
    }
}
