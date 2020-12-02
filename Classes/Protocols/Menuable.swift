//
//  Menuable.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 22.08.2020.
//

#if os(macOS)
import AppKit

public protocol Menuable {
    @discardableResult
    func menu(_ v: Menu) -> Self
    
    @discardableResult
    func menu(@MenuBuilder content: @escaping MenuBuilder.Block) -> Self
    
    @discardableResult
    func menu(@MenuBuilder content: @escaping (Menu) -> MenuBuilderContent) -> Self
}

protocol _Menuable: Menuable {
    func _setMenu(_ v: Menu)
}

extension Menuable {
    @discardableResult
    public func menu(@MenuBuilder content: @escaping MenuBuilder.Block) -> Self {
        menu(.init(content: content))
    }
    
    @discardableResult
    public func menu(@MenuBuilder content: @escaping (Menu) -> MenuBuilderContent) -> Self {
        let m = Menu()
        m.parseMenuBuilder(content(m).menuBuilderContent)
        return menu(m)
    }
}

@available(iOS 13.0, macOS 10.15, *)
extension Menuable {
    @discardableResult
    public func menu(_ value: Menu) -> Self {
        guard let s = self as? _Menuable else { return self }
        s._setMenu(value)
        return self
    }
}

// for iOS lower than 13
extension _Menuable {
    @discardableResult
    public func allowMixedState(_ value: Menu) -> Self {
        _setMenu(value)
        return self
    }
}
#endif
