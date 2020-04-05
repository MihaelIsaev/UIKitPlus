//___FILEHEADER___

import UIKitPlus

extension UButton {
    static var back: UButton {
        UButton().image(.iconBack).tint(0x9FA4B6.color / .white).size(25, 18)
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

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)
struct BackButton_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            UButton.back.centerInSuperview()
        }
        .colorScheme(.light)
        .layout(.fixed(width: 50, height: 50))
    }
}
@available(iOS 13.0, *)
struct GrayButton_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            UButton.gray.title("Gray Button").edgesToSuperview(h: 8).centerYInSuperview()
        }
        .colorScheme(.dark)
        .layout(.fixed(width: 375, height: 60))
    }
}
@available(iOS 13.0, *)
struct GithubButton_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            UButton.github.title("Github").edgesToSuperview(h: 8).centerYInSuperview()
        }
        .colorScheme(.light)
        .layout(.fixed(width: 375, height: 60))
    }
}
#endif
