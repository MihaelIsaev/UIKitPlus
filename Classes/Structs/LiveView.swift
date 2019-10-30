#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
public struct LiveView: UIViewRepresentable {
    let view: UIView
    
    public init (_ vc: UIViewController) {
        self.view = vc.view
    }
    
    public init (_ view: UIView) {
        self.view = view
    }
    
    public func makeUIView(context: Context) -> UIView { view }
    
    public func updateUIView(_ view: UIView, context: Context) {}
}
#endif
