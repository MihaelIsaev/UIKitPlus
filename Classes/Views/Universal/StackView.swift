#if os(macOS)
import AppKit
#else
import UIKit
#endif

public typealias UStackView = StackView
open class StackView: _StackView {
    public override init () {
        super.init()
    }
    
    public init (_ viewBuilderItem: ViewBuilderItemable) {
        super.init(frame: .zero)
        add(item: viewBuilderItem)
    }
    
    public init (@ViewBuilder block: ViewBuilder.SingleView) {
        super.init(frame: .zero)
        add(item: block())
    }
    
    public init (@ViewBuilder block: (StackView) -> ViewBuilder.Result) {
        super.init(frame: .zero)
        add(item: block(self))
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> Self {
        add(item: block())
        return self
    }
    
    public static func subviews(@ViewBuilder block: ViewBuilder.SingleView) -> VStack {
        .init(block: block)
    }
    
    // Mask: Axis
    
    #if os(macOS)
    @discardableResult
    public func orientation(_ orientation: NSUserInterfaceLayoutOrientation) -> StackView {
        self.orientation = orientation
        return self
    }
    #else
    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> StackView {
        self.axis = axis
        return self
    }
    #endif
}

#if os(macOS)
public typealias _STV = NSStackView
#else
public typealias _STV = UIStackView
#endif

open class _StackView: _STV, AnyDeclarativeProtocol, DeclarativeProtocolInternal, EditableStackView {
    public var declarativeView: _StackView { self }
    public lazy var properties = Properties<_StackView>()
    lazy var _properties = PropertiesInternal()
    
    @State public var height: CGFloat = 0
    @State public var width: CGFloat = 0
    @State public var top: CGFloat = 0
    @State public var leading: CGFloat = 0
    @State public var left: CGFloat = 0
    @State public var trailing: CGFloat = 0
    @State public var right: CGFloat = 0
    @State public var bottom: CGFloat = 0
    @State public var centerX: CGFloat = 0
    @State public var centerY: CGFloat = 0
    
    var __height: State<CGFloat> { _height }
    var __width: State<CGFloat> { _width }
    var __top: State<CGFloat> { _top }
    var __leading: State<CGFloat> { _leading }
    var __left: State<CGFloat> { _left }
    var __trailing: State<CGFloat> { _trailing }
    var __right: State<CGFloat> { _right }
    var __bottom: State<CGFloat> { _bottom }
    var __centerX: State<CGFloat> { _centerX }
    var __centerY: State<CGFloat> { _centerY }
    
    open override var tag: Int {
        get { properties.tag }
        set { properties.tag = newValue }
    }
    
    public init () {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        _setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        _setup()
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setup() {
        spacing = 0
    }
    
    #if os(macOS)
    open override func layout() {
        super.layout()
        onLayoutSubviews()
    }
    
    open override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        movedToSuperview()
    }
    #else
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    #endif
    
    // Mask: Alignment
    
    #if os(macOS)
    @discardableResult
    public func alignment(_ alignment: NSLayoutConstraint.Attribute) -> Self {
        self.alignment = alignment
        return self
    }
    #else
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    #endif
    
    // Mask: Distribution
    
    @discardableResult
    public func distribution(_ distribution: _STV.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
    // Mask: Spacing
    
    @discardableResult
    public func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    @discardableResult
    public func spacing(_ state: State<CGFloat>) -> Self {
        state.listen { [weak self] new in
            self?.spacing = new
        }
        self.spacing = state.wrappedValue
        return self
    }
    
    @discardableResult
    public func spacing<V>(_ expressable: ExpressableState<V, CGFloat>) -> Self {
        expressable.state.listen { [weak self] _,_ in
            self?.spacing = expressable.value()
        }
        self.spacing = expressable.value()
        return self
    }
    
    func add(item: ViewBuilderItemable) {
        switch item.viewBuilderItem {
            case .single(let view):
                addArrangedSubview(view)
            case .multiple(let views):
                views.forEach { addArrangedSubview($0) }
            case .forEach(let fr):
                #if os(macOS)
                let stack = StackView().orientation(fr.orientation ?? orientation)
                #else
                let stack = StackView().axis(fr.axis ?? axis)
                #endif
                fr.allItems().forEach {
                    #if os(macOS)
                    stack.addArrangedSubview([$0].flatten(fr.orientation ?? orientation))
                    #else
                    stack.addArrangedSubview([$0].flatten(fr.axis ?? axis))
                    #endif
                }
                addArrangedSubview(stack)
                fr.subscribeToChanges({}, { deletions, insertions, _ in
                    stack.arrangedSubviews.removeFromSuperview(at: deletions)
                    insertions.forEach {
                        #if os(macOS)
                        stack.add(arrangedView: [fr.items(at: $0)].flatten(fr.orientation ?? self.orientation), at: $0)
                        #else
                        stack.add(arrangedView: [fr.items(at: $0)].flatten(fr.axis ?? self.axis), at: $0)
                        #endif
                    }
                }) {}
            case .nested(let items):
                items.forEach { add(item: $0) }
            case .none:
                break
            }
    }
}

extension Array where Element == ViewBuilderItemable {
    #if os(macOS)
    fileprivate func flatten(_ orientation: NSUserInterfaceLayoutOrientation) -> BaseView {
        let stackView = StackView().orientation(orientation)
        forEach { stackView.add(item: $0) }
        return stackView
    }
    #else
    fileprivate func flatten(_ axis: NSLayoutConstraint.Axis) -> BaseView {
        let stackView = StackView().axis(axis)
        forEach { stackView.add(item: $0) }
        return stackView
    }
    #endif
}
