//___FILEHEADER___

import UIKitPlus

final class MainViewController: ViewController {
    override func buildUI() {
        super.buildUI()
        self.view.backgroundColor = .white / .black
        body {
            UVStack {
                UText("Main View Controller")
                    .color(.black / .white)
                UVSpace(8)
                UButton("Logout")
                    .background(.clear)
                    .backgroundHighlighted(.lightGray / .darkGray)
                    .color(.black / .white)
                    .height(44)
                    .border(1, .red)
                    .circle()
                    .onTapGesture {
//                    Session.destroy()
                        App.mainScene.switch(to: .logout, animation: .dismiss)
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
struct MainViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            MainViewController()
        }
        .colorScheme(.dark)
        .device(.iPhoneX)
        .language(.en)
    }
}
#endif
