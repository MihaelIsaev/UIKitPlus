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

extension Array where Element: AttributedString {
    public func joined() -> AttrStr {
        let result = AttributedString("")
        forEach {
            result.attributedString.append($0.attributedString)
        }
        return result
    }
    
    public func joined() -> NSMutableAttributedString {
        let result = NSMutableAttributedString(string: "")
        forEach {
            result.append($0.attributedString)
        }
        return result
    }
}
