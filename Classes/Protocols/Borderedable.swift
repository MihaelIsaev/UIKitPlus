#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol Borderedable {
    @discardableResult
    func bordered() -> Self
    
    @discardableResult
    func bordered(_ value: Bool) -> Self
    
    @discardableResult
    func bordered(_ binding: UIKitPlus.State<Bool>) -> Self
    
    @discardableResult
    func bordered<V>(_ expressable: ExpressableState<V, Bool>) -> Self
}

protocol _Borderedable: Borderedable {
    var _borderedState: State<Bool> { get }
    
    func _setBordered(_ v: Bool)
}

extension Borderedable {
    @discardableResult
    public func bordered() -> Self {
        bordered(true)
    }
    
    @discardableResult
    public func bordered(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { self.bordered($0) }
        return bordered(binding.wrappedValue)
    }
    
    @discardableResult
    public func bordered<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        bordered(expressable.unwrap())
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension Borderedable {
    @discardableResult
    public func bordered(_ value: Bool) -> Self {
        guard let s = self as? _Borderedable else { return self }
        s._setBordered(value)
        return self
    }
}

// for iOS lower than 13
extension _Borderedable {
    @discardableResult
    public func bordered(_ value: Bool) -> Self {
        _setBordered(value)
        return self
    }
}
