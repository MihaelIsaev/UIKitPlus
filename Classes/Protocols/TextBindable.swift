import UIKit

public protocol TextBindable {
    @discardableResult
    func bind(_ to: UIKitPlus.State<String>) -> Self
}

protocol _TextBindable: TextBindable {
    func _setTextBind(_ binding: State<String>?)
}

extension TextBindable {
    @discardableResult
    public func bind(_ to: State<String>) -> Self {
        guard let s = self as? _TextBindable else { return self }
        s._setTextBind(to)
        return self
    }
}
