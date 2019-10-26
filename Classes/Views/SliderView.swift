import UIKit

open class SliderView: UISlider, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: SliderView { self }
    public lazy var properties = Properties<SliderView>()
    lazy var _properties = PropertiesInternal()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        buildView()
        addTarget(self, action: #selector(_valueChanged), for: .valueChanged)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func buildView() {}
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    @discardableResult
    public func value(_ value: Float) -> Self {
        self.value = value
        return self
    }
    
    @discardableResult
    public func minimumValue(_ value: Float) -> Self {
        minimumValue = value
        return self
    }
    
    @discardableResult
    public func maximumValue(_ value: Float) -> Self {
        maximumValue = value
        return self
    }
    
    @discardableResult
    public func minimumValueImage(_ value: UIImage?) -> Self {
        minimumValueImage = value
        return self
    }
    
    @discardableResult
    public func maximumValueImage(_ value: UIImage?) -> Self {
        maximumValueImage = value
        return self
    }
    
    @discardableResult
    public func isContinuous(_ value: Bool = true) -> Self {
        isContinuous = value
        return self
    }
    
    @discardableResult
    public func minimumTrackTintColor(_ value: UIColor?) -> Self {
        minimumTrackTintColor = value
        return self
    }
    
    @discardableResult
    public func minimumTrackTintColor(_ value: Int?) -> Self {
        minimumTrackTintColor = value?.color
        return self
    }
    
    @discardableResult
    public func maximumTrackTintColor(_ value: UIColor?) -> Self {
        maximumTrackTintColor = value
        return self
    }
    
    @discardableResult
    public func maximumTrackTintColor(_ value: Int?) -> Self {
        maximumTrackTintColor = value?.color
        return self
    }
    
    @discardableResult
    public func thumbTintColor(_ value: UIColor?) -> Self {
        thumbTintColor = value
        return self
    }
    
    @discardableResult
    public func thumbTintColor(_ value: Int?) -> Self {
        thumbTintColor = value?.color
        return self
    }
    
    @discardableResult
    public func tintColor(_ value: UIColor?) -> Self {
        tintColor = value
        return self
    }
    
    @discardableResult
    public func tintColor(_ value: Int?) -> Self {
        tintColor = value?.color
        return self
    }
    
    @discardableResult
    public func thumbImage(_ value: UIImage?, for state: UIControl.State = .normal) -> Self {
        setThumbImage(value, for: state)
        return self
    }
    
    var step: Float?
    
    @discardableResult
    public func step(_ value: Float) -> Self {
        step = value
        return self
    }
    
    // MARK: Value changed
    
    var _previousSteppedValue: Float?
    
    @objc
    private func _valueChanged() {
        if let step = step {
            let roundedValue = round(value / step) * step
            value = roundedValue
            if value != _previousSteppedValue {
                _onChange?(value)
            }
            _previousSteppedValue = value
        } else {
            _onChange?(value)
        }
    }
    
    public typealias OnChange = (Float) -> Void
    
    private var _onChange: OnChange?
    
    @discardableResult
    public func onChange(_ value: @escaping OnChange) -> Self {
        _onChange = value
        return self
    }
}
