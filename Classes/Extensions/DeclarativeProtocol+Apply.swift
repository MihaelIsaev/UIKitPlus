//
// Created by Kevin Guo on 2022/1/3.
//

import Foundation
extension DeclarativeProtocol {

    @discardableResult
    public func apply(_ closure: (V) -> Void) -> Self {
        closure(declarativeView)
        return self
    }
}
