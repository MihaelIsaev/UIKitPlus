//
//  AttrStr+Joined.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 09.02.2020.
//

import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension Array: AnyString where Element == AnyString {
    public var attrString: NSAttributedString { map { $0.attrString }.joined() }
    
    public static func make(_ v: NSAttributedString) -> Self {
        .init([v])
    }
}

extension Array where Element: NSAttributedString {
    public func joined() -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        forEach {
            result.append($0)
        }
        return result
    }
}

extension Array where Element: AttributedString {
    public func joined() -> AttrStr {
        let result = AttributedString("")
        forEach {
            result._attributedString.append($0._attributedString)
        }
        return result
    }
    
    public func joined() -> NSMutableAttributedString {
        let result = NSMutableAttributedString(string: "")
        forEach {
            result.append($0._attributedString)
        }
        return result
    }
}
