import UIKit

open class ViewController: UIViewController {
    public init () {
        super.init(nibName: nil, bundle: nil)
        buildUI()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        buildUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func buildUI() {
        view.backgroundColor = .white
    }
    
    public var isAppearedOnce = false
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isAppearedOnce {
            isAppearedOnce = true
            viewDidAppearFirstTime(animated)
        }
    }
    
    open func viewDidAppearFirstTime(_ animated: Bool) {}
}
