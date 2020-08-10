#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol BackgroundColorable {
    @discardableResult
    func background(_ color: UColor) -> Self
    
    @discardableResult
    func background(_ number: Int) -> Self
    
    @discardableResult
    func background(_ state: State<UColor>) -> Self
    
    @discardableResult
    func background<V>(_ expressable: ExpressableState<V, UColor>) -> Self
}

protocol _BackgroundColorable: BackgroundColorable {
    func _setBackgroundColor(_ v: UColor)
}

extension BackgroundColorable {
    @discardableResult
    public func background(_ number: Int) -> Self {
        background(number.color)
    }
    
    @discardableResult
    public func background(_ state: State<UColor>) -> Self {
        background(state.wrappedValue)
        state.listen {
            self.background($0)
        }
        return self
    }
    
    @discardableResult
    public func background<V>(_ expressable: ExpressableState<V, UColor>) -> Self {
        background(expressable.value())
        expressable.state.listen {
            self.background(expressable.value())
        }
        return self
    }
}

@available(iOS 13.0, *)
extension BackgroundColorable {
    @discardableResult
    public func background(_ color: UColor) -> Self {
        guard let s = self as? _BackgroundColorable else { return self }
        s._setBackgroundColor(color)
        return self
    }
}

// for iOS lower than 13
extension _BackgroundColorable {
    @discardableResult
    public func background(_ color: UColor) -> Self {
        _setBackgroundColor(color)
        return self
    }
}
