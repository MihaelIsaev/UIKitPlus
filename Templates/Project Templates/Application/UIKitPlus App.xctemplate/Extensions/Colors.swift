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

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct Colors_Preview: PreviewProvider, DeclarativePreviewGroup {
    static var previewGroup: PreviewGroup {
        PreviewGroup {
            Preview {
                UView().edgesToSuperview().background(.dynamicBlack)
            }
            .title("Dynamic Black")
            .colorScheme(.light)
            .layout(.fixed(width: 200, height: 50))
            Preview {
                UView().edgesToSuperview().background(.dynamicWhite)
            }
            .title("Dynamic White")
            .colorScheme(.light)
            .layout(.fixed(width: 200, height: 50))
            Preview {
                UView().edgesToSuperview().background(.red)
            }
            .title("Red")
            .colorScheme(.light)
            .layout(.fixed(width: 200, height: 50))
            Preview {
                UView().edgesToSuperview().background(.green)
            }
            .title("Green")
            .colorScheme(.light)
            .layout(.fixed(width: 200, height: 50))
            Preview {
                UView().edgesToSuperview().background(.blue)
            }
            .title("Blue")
            .colorScheme(.light)
            .layout(.fixed(width: 200, height: 50))
        }
    }
}
#endif
