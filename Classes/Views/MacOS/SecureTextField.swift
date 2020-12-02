#if os(macOS)
import Foundation
import AppKit

open class USecureTextField: UTextField {
    override func _setup() {
        cell = NSSecureTextFieldCell(textCell: attributedStringValue.string)
        isEditable = true
        super._setup()
    }
}

//extension USecureTextField: _Secureable {
//    func _setSecure(_ v: Bool) {
//        var isEditable = self.isEditable
//        guard let cell = cell as? NSTextFieldCell else { return }
//        let c: NSTextFieldCell
//        if v {
//            c = NSSecureTextFieldCell(textCell: attributedStringValue.string)
//        } else {
//            c = NSTextFieldCell(textCell: attributedStringValue.string)
//        }
//        c.backgroundColor = cell.backgroundColor
//        c.drawsBackground = cell.drawsBackground
//        c.textColor = cell.textColor
//        c.bezelStyle = cell.bezelStyle
//        c.placeholderString = cell.placeholderString
//        c.placeholderAttributedString = cell.placeholderAttributedString
//        c.allowedInputSourceLocales = cell.allowedInputSourceLocales
//        self.cell = c
//        self.isEditable = isEditable
//
////        resignFirstResponder()
////        abortEditing()
////        becomeFirstResponder()
//
////        setNeedsDisplay()
////        layer?.layoutIfNeeded()
//
//    }
//}

extension USecureTextField: _BulletsEchoable {
    func _setEchosBullets(_ v: Bool) {
        (cell as? NSSecureTextFieldCell)?.echosBullets = v
    }
}
#endif
