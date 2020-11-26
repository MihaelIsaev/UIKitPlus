import UIKit

public protocol BackgroundColorable {
    @discardableResult
    func background(_ color: UIColor) -> Self
    
    @discardableResult
    func background(_ number: Int) -> Self
    
    @discardableResult
    func background(_ state: UState<UIColor>) -> Self
    
    @discardableResult
    func background<V>(_ expressable: ExpressableState<V, UIColor>) -> Self
}

protocol _BackgroundColorable: BackgroundColorable {
    func _setBackgroundColor(_ v: UIColor)
}

extension BackgroundColorable {
    @discardableResult
    public func background(_ number: Int) -> Self {
        background(number.color)
    }
    
    @discardableResult
    public func background(_ state: UState<UIColor>) -> Self {
        background(state.wrappedValue)
        state.listen {
            self.background($0)
        }
        return self
    }
    
    @discardableResult
    public func background<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
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
    public func background(_ color: UIColor) -> Self {
        guard let s = self as? _BackgroundColorable else { return self }
        s._setBackgroundColor(color)
        return self
    }
}

// for iOS lower than 13
extension _BackgroundColorable {
    @discardableResult
    public func background(_ color: UIColor) -> Self {
        _setBackgroundColor(color)
        return self
    }
}
