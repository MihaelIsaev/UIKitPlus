//___FILEHEADER___

import UIKitPlus

final class SplashViewController: ViewController {
    override func buildUI() {
        super.buildUI()
        self.view.backgroundColor = .white / .black
        body {
            UVStack {
                UText("Splash View Controller")
                    .compressionResistance(x: .defaultHigh)
                    .color(.black / .white)
                UVSpace(8)
                ActivityIndicator().color(.dynamicBlack).animate()
            }
            .alignment(.center)
            .centerInSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            App.mainScene.switch(to: .main, animation: .fade)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct SplashViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            SplashViewController()
        }
        .colorScheme(.dark)
        .device(.iPhoneX)
        .language(.en)
    }
}
#endif
