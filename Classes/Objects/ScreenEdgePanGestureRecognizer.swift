import UIKit

final public class ScreenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer, _GestureTrackable, _GestureDelegatorable {
    var _tracker = _GestureTracker()
    var _delegator = _GestureDelegator()
    
    public init(edges: UIRectEdge) {
        super.init(target: _tracker, action: #selector(_tracker.handle))
        self.edges = edges
        delegate = _delegator
    }
    
    @discardableResult
    public func edges(_ v: UIRectEdge) -> Self {
        edges = v
        return self
    }
    
    @discardableResult
    public func edges(_ state: UIKitPlus.State<UIRectEdge>) -> Self {
        state.listen { self.edges = $0 }
        return self
    }

    @discardableResult
    public func edges<V>(_ expressable: ExpressableState<V, UIRectEdge>) -> Self {
        edges(expressable.unwrap())
    }
    
    var _tag: Int = 0
    public override var tag: Int {
        get { _tag }
        set { _tag = newValue }
    }
}
