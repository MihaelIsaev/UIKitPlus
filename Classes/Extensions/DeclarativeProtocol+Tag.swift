#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension DeclarativeProtocol {
    @discardableResult
    public mutating func tag(_ value: Int) -> Self {
        tag = value
        return self
    }
}
