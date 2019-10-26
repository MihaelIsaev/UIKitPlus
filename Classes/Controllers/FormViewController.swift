import UIKit

open class FormViewController: ViewController {
    public lazy var scrollView = ScrollView().edgesToSuperview()
    public lazy var stackView = VStackView().edgesToSuperview().width(to: .width, of: scrollView)
    
    open override func buildUI() {
        super.buildUI()
        view.body { scrollView }
        scrollView.body { stackView }
    }
    
    override open func keyboardAppeared(_ height: CGFloat, _ animationDuration: TimeInterval, _ inThisController: Bool) {
        super.keyboardAppeared(height, animationDuration, inThisController)
        scrollView.bottom = height * (-1)
        view.layoutIfNeeded()
    }
    
    override open func keyboardDisappeared(_ animationDuration: TimeInterval, _ inThisController: Bool) -> Bool {
        guard super.keyboardDisappeared(animationDuration, inThisController) else { return false }
        scrollView.bottom = 0
        view.layoutIfNeeded()
        return true
    }
}
