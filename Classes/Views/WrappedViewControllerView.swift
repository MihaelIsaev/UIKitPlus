import UIKit

open class WrappedViewControllerView<V, P>: View, WrappedViewControllerable where V: UIViewController, P: UIViewController {
    public let inner: V
    public let parent: P
    
    public var protocolView: View { return self }
    public var protocolController: UIViewController { return inner }
    
    public init (_ inner: V, parent: P) {
        self.inner = inner
        self.parent = parent
        parent.addChild(inner)
        super.init(frame: .zero)
        inner.didMove(toParent: parent)
        addSubview(inner.view)
        top(to: .top, of: inner.view)
        leading(to: .leading, of: inner.view)
        trailing(to: .trailing, of: inner.view)
        bottom(to: .bottom, of: inner.view)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
