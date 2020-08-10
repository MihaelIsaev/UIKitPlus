#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol TextBindable {
    @discardableResult
    func bind(_ to: UIKitPlus.State<String>) -> Self
}

protocol _TextBindable: TextBindable {
    func _setTextBind(_ binding: State<String>?)
}

@available(iOS 13.0, *)
extension TextBindable {
    @discardableResult
    public func bind(_ to: State<String>) -> Self {
        guard let s = self as? _TextBindable else { return self }
        s._setTextBind(to)
        return self
    }
}

// for iOS lower than 13
extension _TextBindable {
    @discardableResult
    public func bind(_ to: State<String>) -> Self {
        _setTextBind(to)
        return self
    }
}
