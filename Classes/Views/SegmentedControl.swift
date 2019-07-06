import UIKit

class SegmentedControl: UISegmentedControl, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: SegmentedControl { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
    public init(_ items: Any...) {
        super.init(items: items)
    }
    
    @discardableResult
    public static func items(_ items: Any...) -> SegmentedControl {
        return SegmentedControl(items)
    }
    
    required init?(coder aDecoder: NSCoder) {
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
    public func select(index: Int) -> SegmentedControl {
        selectedSegmentIndex = index
        return self
    }
}
