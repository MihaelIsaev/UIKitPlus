//___FILEHEADER___

import UIKitPlus

extension UIColor {
    /// dynamic color (will be different in `dark` and `light` modes)
    static var dynamicBlack = .black / .white /// `.white` will be used for `darkMode`
    static var dynamicWhite = .white / .black /// `.black` will be used for `darkMode`
    
    /// `hex` color
    static var blackHole = 0x171A1D.color
    
    /// classic `UIColor`
    static var myColor = UIColor(red: 35, green: 127, blue: 201, alpha: 1)
}

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)
struct DynamicBlack_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            UView().edgesToSuperview().background(.dynamicBlack)
        }
        .title("Dynamic Black")
        .colorScheme(.light)
        .layout(.fixed(width: 200, height: 50))
    }
}
#endif
