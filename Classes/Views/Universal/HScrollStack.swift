#if !os(macOS)
import UIKit
#else
import AppKit
#endif

@available(*, deprecated, renamed: "UHScrollStack")
public typealias HScrollStack = UHScrollStack

open class UHScrollStack: UScrollView {
    lazy var stack = UHStack().edgesToSuperview().heightToSuperview()
    
    #if os(macOS)
    fileprivate lazy var _docView = UView()
        .leadingToSuperview()
        .edgesToSuperview(v: 0)
    #endif
    
    #if os(macOS)
    public init (@BodyBuilder block: BodyBuilder.SingleView) {
        super.init(frame: .zero)
        hasHorizontalScroller = true
        borderType = .noBorder
        documentView(_docView)
        _docView.body {
            stack.subviews(block: block)
        }
        _setup()
    }
    #else
    public override init (@BodyBuilder block: BodyBuilder.SingleView) {
        super.init(frame: .zero)
        body {
            stack.subviews(block: block)
        }
        _setup()
    }
    #endif
    
    public override init() {
        super.init(frame: .zero)
        #if !os(macOS)
        body {
            stack
        }
        #else
        hasHorizontalScroller = true
        borderType = .noBorder
        documentView(_docView)
        _docView.body {
            stack
        }
        #endif
        _setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        #if !os(macOS)
        body {
            stack
        }
        #else
        hasHorizontalScroller = true
        borderType = .noBorder
        documentView(_docView)
        _docView.body {
            stack
        }
        #endif
        _setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setup() {
        #if os(macOS)
        #else
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (self: Self?, previousTraitCollection) in
                guard let self else { return }
                self.properties.traitCollectionDidChangeHandlers.values.forEach { $0(self.traitCollection) }
            }
        }
        #endif
    }
    
    #if os(macOS)
    #else
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                properties.traitCollectionDidChangeHandlers.values.forEach { $0(traitCollection) }
            }
        }
    }
    #endif
    
    #if !os(macOS)
    // Forbids vertical scrolling
    public override var contentOffset: CGPoint {
        get { super.contentOffset }
        set {
            super.contentOffset = .init(x: newValue.x, y: 0)
        }
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
    
    // Mask: Alignment
    
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
    
    // Mask: Distribution
    
    @discardableResult
    public func distribution(_ distribution: _STV.Distribution) -> Self {
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
}
