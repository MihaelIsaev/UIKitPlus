import UIKit

public protocol TextLineable {
    @discardableResult
    func lines(_ number: Int) -> Self
    
    @discardableResult
    func multiline() -> Self
}

protocol _TextLineable: TextLineable {
    func _setNumbelOfLines(_ v: Int)
}

extension TextLineable {
    @discardableResult
    public func lines(_ number: Int) -> Self {
        guard let s = self as? _TextLineable else { return self }
        s._setNumbelOfLines(number)
        return self
    }
    
    @discardableResult
    public func multiline() -> Self {
        guard let s = self as? _TextLineable else { return self }
        s._setNumbelOfLines(0)
        return self
    }
}
