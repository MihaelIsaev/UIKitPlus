//___FILEHEADER___

import UIKitPlus

extension UButton {
    static var back: UButton {
        UButton()//.image("back")
    }
    static var gray: UButton {
        UButton()
            .circle()
            .background(.lightGray / .darkGray)
            .color(.black / .white)
            .height(54)
            .font(.helveticaNeueMedium, 16)
    }
    static var github: UButton {
        UButton()
            .circle()
            .background(.blackHole / .white)
            .color(.white / .black)
            .height(54)
            .font(.helveticaNeueMedium, 16)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct Buttons_Preview: PreviewProvider, DeclarativePreviewGroup {
    static var previewGroup: PreviewGroup {
        PreviewGroup {
            Preview {
                UButton.gray.title("Gray Button").edgesToSuperview(h: 8).centerYInSuperview()
            }
            .title("gray")
            .colorScheme(.dark)
            .layout(.fixed(width: 375, height: 60))
            Preview {
                UButton.github.title("Github").edgesToSuperview(h: 8).centerYInSuperview()
            }
            .title("github")
            .colorScheme(.light)
            .layout(.fixed(width: 375, height: 60))
        }
    }
}
#endif
