//
//  UIFont+Family.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 30/06/2019.
//

import UIKit

extension UIFont {
    public convenience init? (_ identifier: FontIdentifier, size: CGFloat) {
        self.init(name: identifier.fontName, size: size)
    }
}

public protocol FontIdentifierable {
    var fontName: String { get }
}

public struct FontIdentifier: FontIdentifierable {
    public let fontName: String
    
    public init (_ fontName: String) {
        self.fontName = fontName
    }
}

/** Usage example
 extension FontIdentifier {
    public static var sfProBold = FontIdentifier("SFProDisplay-Bold")
    public static var sfProRegular = FontIdentifier("SFProDisplay-Regular")
    public static var sfProMedium = FontIdentifier("SFProDisplay-Medium")
 }
 
 And then somewhere
 
 Label("hello world").font(.sfProRegular, 16)
 TextField().font(.sfProRegular, 16)
 */
