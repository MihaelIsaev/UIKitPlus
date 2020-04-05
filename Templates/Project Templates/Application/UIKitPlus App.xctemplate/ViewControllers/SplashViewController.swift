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
                VSpace(8)
                ActivityIndicator().color(.dynamicBlack).animate()
            }
            .alignment(.center)
            .centerInSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.rootController.switch(to: .main, animation: .fade)
        }
    }
}

extension SplashViewController {
    static var _mock: SplashViewController {
        SplashViewController()
    }
}

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)
struct SplashViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            SplashViewController._mock
        }
        .colorScheme(.dark)
        .device(.iPhoneX)
        .language(.en)
    }
}
#endif
