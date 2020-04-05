//___FILEHEADER___

import UIKitPlus

final class ___FILEBASENAMEASIDENTIFIER___: ___VARIABLE_UIKitPlusSubclass___ {
    override func buildView() {
        super.buildView()
        body {
            UView()
        }
    }
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    static var _mock: ___FILEBASENAMEASIDENTIFIER___ {
        ___FILEBASENAMEASIDENTIFIER___()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ___FILEBASENAMEASIDENTIFIER____Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            ___FILEBASENAMEASIDENTIFIER___._mock
        }
        .colorScheme(.dark)
        .device(.iPhoneX)
        .language(.en)
    }
}
#endif
