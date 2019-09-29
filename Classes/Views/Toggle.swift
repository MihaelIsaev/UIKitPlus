import UIKit

open class Toggle: UISwitch, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Toggle { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    var binding: UIKitPlus.State<Bool>?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(_ state: UIKitPlus.State<Bool>) {
        binding = state
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(changed), for: .valueChanged)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    // MARK: Handler
    
    private var _changed: (Bool) -> Void = { _ in }
    
    @objc
    private func changed() {
        binding?.wrappedValue = isOn
        _changed(isOn)
    }
    
    @discardableResult
    public func onChange(_ closure: @escaping (Bool) -> Void) -> Self {
        _changed = closure
        return self
    }
    
    @discardableResult
    public func onTint(_ color: UIColor) -> Self {
        onTintColor = color
        return self
    }
    
    @discardableResult
    public func onTint(_ color: Int) -> Self {
        onTintColor = color.color
        return self
    }
    
    @discardableResult
    public func thumbTint(_ color: UIColor) -> Self {
        thumbTintColor = color
        return self
    }
    
    @discardableResult
    public func thumbTint(_ color: Int) -> Self {
        thumbTintColor = color.color
        return self
    }
    
    @discardableResult
    public func onImage(_ image: UIImage?) -> Self {
        onImage = image
        return self
    }
    
    @discardableResult
    public func offImage(_ image: UIImage?) -> Self {
        offImage = image
        return self
    }
}
