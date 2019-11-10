import UIKit

open class HScrollStack: ScrollView {
    lazy var stack = HStack().edgesToSuperview().widthToSuperview()
    
    public override init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        body {
            stack.subviews(block: block)
        }
    }
    
    public override init() {
        super.init(frame: .zero)
        body {
            stack
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        body {
            stack
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* Add a view to the end of the arrangedSubviews list.
    Maintains the rule that the arrangedSubviews list is a subset of the
    subviews list by adding the view as a subview of the receiver if
    necessary.
       Does not affect the subview ordering if view is already a subview
    of the receiver.
    */
    open func addArrangedSubview(_ view: UIView) {
        stack.addArrangedSubview(view)
    }
    
    /* Removes a subview from the list of arranged subviews without removing it as
     a subview of the receiver.
        To remove the view as a subview, send it -removeFromSuperview as usual;
     the relevant UIStackView will remove it from its arrangedSubviews list
     automatically.
     */
    open func removeArrangedSubview(_ view: UIView) {
        stack.removeArrangedSubview(view)
    }

    /*
     Adds the view as a subview of the container if it isn't already.
        Updates the stack index (but not the subview index) of the
     arranged subview if it's already in the arrangedSubviews list.
     */
    open func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stack.insertArrangedSubview(view, at: stackIndex)
    }
    
    // Mask: Alignment
    
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        stack.alignment = alignment
        return self
    }
    
    // Mask: Distribution
    
    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
        stack.distribution = distribution
        return self
    }
    
    // Mask: Spacing
    
    @discardableResult
    public func spacing(_ spacing: CGFloat) -> Self {
        stack.spacing = spacing
        return self
    }
    
    @discardableResult
    public func spacing(_ state: State<CGFloat>) -> Self {
        state.listen { [weak self] new in
            self?.stack.spacing = new
        }
        stack.spacing = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func spacing<V>(_ expressable: ExpressableState<V, CGFloat>) -> Self {
        expressable.state.listen { [weak self] _,_ in
            self?.stack.spacing = expressable.value()
        }
        stack.spacing = expressable.value()
        return self
    }
}
