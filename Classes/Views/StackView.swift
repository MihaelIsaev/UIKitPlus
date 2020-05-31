import UIKit

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
    
    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> StackView {
        self.axis = axis
        return self
    }
}

open class _StackView: UIStackView, AnyDeclarativeProtocol, DeclarativeProtocolInternal, EditableStackView {
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
    
    public init () {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    // Mask: Alignment
    
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    // Mask: Distribution
    
    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
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
                let vStack = VStack()
                fr.allItems().forEach {
                    vStack.addArrangedSubview([$0].flatten(fr.axis ?? axis))
                }
                addArrangedSubview(vStack)
                fr.subscribeToChanges({}, { deletions, insertions, _ in
                    vStack.arrangedSubviews.removeFromSuperview(at: deletions)
                    insertions.forEach {
                        vStack.add(arrangedView: [fr.items(at: $0)].flatten(fr.axis ?? self.axis), at: $0)
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
    fileprivate func flatten(_ axis: NSLayoutConstraint.Axis) -> UIView {
        let stackView = StackView().axis(axis)
        forEach { stackView.add(item: $0) }
        return stackView
    }
}
