import UIKit

open class SegmentedControl: UISegmentedControl, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: SegmentedControl { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(_ items: [SegmentControlable]) {
        super.init(items: [])
        items.enumerated().forEach { offset, item in
            switch item.item {
            case .title(let title): insertSegment(withTitle: title, at: offset, animated: false)
            case .image(let image): insertSegment(with: image, at: offset, animated: false)
            }
        }
    }
    
    public convenience init(_ items: SegmentControlable...) {
        self.init(items)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @discardableResult
    public static func items(_ items: SegmentControlable...) -> SegmentedControl {
        return SegmentedControl(items)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    @objc
    private func valueChanged() {
        _valueChanged?(selectedSegmentIndex)
    }
    
    public typealias ChangedClosure = (Int) -> Void
    
    private var _valueChanged: ChangedClosure?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func momentary(_ value: Bool = true) -> SegmentedControl {
        isMomentary = value
        return self
    }
    
    @discardableResult
    public func apportionsSegmentWidthsByContent(_ value: Bool = true) -> SegmentedControl {
        apportionsSegmentWidthsByContent = value
        return self
    }
    
    @discardableResult
    public func select(_ index: Int) -> SegmentedControl {
        selectedSegmentIndex = index
        return self
    }
    
    @discardableResult
    public func changed(_ callback: @escaping ChangedClosure) -> SegmentedControl {
        _valueChanged = callback
        return self
    }
}
