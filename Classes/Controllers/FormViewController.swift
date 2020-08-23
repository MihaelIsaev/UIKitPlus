#if !os(macOS)
import UIKit

open class FormViewController: ViewController {
    public lazy var scrollView = ScrollView()
    public lazy var stackView = VStack()
    
    open override func buildUI() {
        super.buildUI()
        view.body {
            scrollView
                .edgesToSuperview(top: 0, leading: 0, trailing: 0)
                .bottomToSuperview($keyboardHeight.map { -1 * $0 })
        }
        scrollView.body {
            stackView
                .edgesToSuperview()
                .width(to: .width, of: scrollView)
        }
    }
}
#endif
