#if os(macOS)
import Cocoa

public protocol Keyable: class {
    @discardableResult
    func key(_ text: String) -> Self
    
    @discardableResult
    func key(_ state: State<String>) -> Self
}

protocol _Keyable: Keyable {
    func _setKey(_ v: String)
}

extension Keyable {
    @discardableResult
    public func key(_ text: String) -> Self {
        guard let s = self as? _Keyable else { return self }
        s._setKey(text)
        return self
    }

    @discardableResult
    public func key(_ state: State<String>) -> Self {
        key(state.wrappedValue)
        state.listen { [weak self] in
            self?.key($0)
        }
        return self
    }
}
#endif
