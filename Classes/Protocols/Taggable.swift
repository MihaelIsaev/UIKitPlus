//
//  Taggable.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 17.04.2020.
//

import UIKit

public protocol Taggable: class {
    var tag: Int { get set }
    
    @discardableResult
    func tag(_ value: Int) -> Self
}

extension Taggable {
    @discardableResult
    public func tag(_ value: Int) -> Self {
        tag = value
        return self
    }
}

extension UIGestureRecognizer: Taggable {
    @objc
    public var tag: Int {
        get { 0 }
        set {}
    }
}
