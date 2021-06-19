#if !os(macOS)
import UIKit
#else
import AppKit
#endif

@available(*, deprecated, renamed: "UVScrollStack")
public typealias VScrollStack = UVScrollStack

open class UVScrollStack: UScrollView {
    lazy var stack = UVStack().edgesToSuperview().widthToSuperview()
    
    #if os(macOS)
    fileprivate lazy var _docView = UView()
        .topToSuperview()
        .edgesToSuperview(h: 0)
        .flipped(true)
    #endif
    
    public init (@BodyBuilder block: BodyBuilder.SingleView) {
        super.init(frame: .zero)
        #if !os(macOS)
        body {
            stack.subviews(block: block)
        }
        #else
        hasVerticalScroller = true
        borderType = .noBorder
        documentView(_docView.body {
            stack.subviews(block: block)
        })
        #endif
    }
    
    public override init() {
        super.init(frame: .zero)
        #if !os(macOS)
        body {
            stack
        }
        #else
        hasVerticalScroller = true
        borderType = .noBorder
        documentView(_docView.body {
            stack
        })
        #endif
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        #if !os(macOS)
        body {
            stack
        }
        #else
        hasVerticalScroller = true
        borderType = .noBorder
        documentView(_docView.body {
            stack
        })
        #endif
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if !os(macOS)
    // Forbids horizontal scrolling
    public override var contentOffset: CGPoint {
        get { super.contentOffset }
        set {
            super.contentOffset = .init(x: 0, y: newValue.y)
        }
    }
    
    // MARK: Keyboard Dismiss Mode
    
    @discardableResult
    public func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        keyboardDismissMode = mode
        return self
    }
    #endif
    
    /* Add a view to the end of the arrangedSubviews list.
    Maintains the rule that the arrangedSubviews list is a subset of the
    subviews list by adding the view as a subview of the receiver if
    necessary.
       Does not affect the subview ordering if view is already a subview
    of the receiver.
    */
    open func addArrangedSubview(_ view: BaseView) {
        stack.addArrangedSubview(view)
    }
    
    /* Removes a subview from the list of arranged subviews without removing it as
     a subview of the receiver.
        To remove the view as a subview, send it -removeFromSuperview as usual;
     the relevant UIStackView will remove it from its arrangedSubviews list
     automatically.
     */
    open func removeArrangedSubview(_ view: BaseView) {
        stack.removeArrangedSubview(view)
    }

    /*
     Adds the view as a subview of the container if it isn't already.
        Updates the stack index (but not the subview index) of the
     arranged subview if it's already in the arrangedSubviews list.
     */
    open func insertArrangedSubview(_ view: BaseView, at stackIndex: Int) {
        stack.insertArrangedSubview(view, at: stackIndex)
    }
    
    // MARK: Alignment
    
    #if !os(macOS)
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        stack.alignment = alignment
        return self
    }
    #else
    @discardableResult
    public func alignment(_ alignment: NSLayoutConstraint.Attribute) -> Self {
        stack.alignment = alignment
        return self
    }
    #endif
    
    // MARK: Distribution
    
    @discardableResult
    public func distribution(_ distribution: _STV.Distribution) -> Self {
        stack.distribution = distribution
        return self
    }
    
    // MARK: Spacing
    
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
}
