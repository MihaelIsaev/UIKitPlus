//___FILEHEADER___

import UIKitPlus

final class WelcomeViewController: ViewController {
//    override var statusBarStyle: StatusBarStyle { .dark }

    override func buildUI() {
        super.buildUI()
        self.view.backgroundColor = .white / .black
        body {
            UVStack {
                UText("Welcome View Controller")
                    .color(.black / .white)
                UVSpace(8)
                UButton("Enter")
                    .background(.clear)
                    .backgroundHighlighted(.lightGray / .darkGray)
                    .color(.black / .white)
                    .height(44)
                    .border(1, .green)
                    .circle()
                    .onTapGesture {
                        App.mainScene.switch(to: .splash, animation: .fade)
                }
            }.centerInSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct WelcomeViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            WelcomeViewController()
        }
        .colorScheme(.dark)
        .device(.iPhoneX)
        .language(.en)
    }
}
#endif
