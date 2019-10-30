#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension ViewController {
    @available(iOS 13.0, *)
    public var liveView: LiveView { .init(self) }
}
#endif
