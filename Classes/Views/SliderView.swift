import UIKit

open class SliderView: UISlider, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: SliderView { self }
    public lazy var properties = Properties<SliderView>()
    lazy var _properties = PropertiesInternal()
    
    @UIKitPlus.State public var height: CGFloat = 0
    @UIKitPlus.State public var width: CGFloat = 0
    @UIKitPlus.State public var top: CGFloat = 0
    @UIKitPlus.State public var leading: CGFloat = 0
    @UIKitPlus.State public var left: CGFloat = 0
    @UIKitPlus.State public var trailing: CGFloat = 0
    @UIKitPlus.State public var right: CGFloat = 0
    @UIKitPlus.State public var bottom: CGFloat = 0
    @UIKitPlus.State public var centerX: CGFloat = 0
    @UIKitPlus.State public var centerY: CGFloat = 0
    
    var __height: UIKitPlus.State<CGFloat> { $height }
    var __width: UIKitPlus.State<CGFloat> { $width }
    var __top: UIKitPlus.State<CGFloat> { $top }
    var __leading: UIKitPlus.State<CGFloat> { $leading }
    var __left: UIKitPlus.State<CGFloat> { $left }
    var __trailing: UIKitPlus.State<CGFloat> { $trailing }
    var __right: UIKitPlus.State<CGFloat> { $right }
    var __bottom: UIKitPlus.State<CGFloat> { $bottom }
    var __centerX: UIKitPlus.State<CGFloat> { $centerX }
    var __centerY: UIKitPlus.State<CGFloat> { $centerY }
    
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
    
    var bindValue: UIKitPlus.State<Float>?
    
    @discardableResult
    public func value(_ binding: UIKitPlus.State<Float>) -> Self {
        bindValue = binding
        binding.listen { self.value($0) }
        return value(binding.wrappedValue)
    }
    
    @discardableResult
    public func value<V>(_ expressable: ExpressableState<V, Float>) -> Self {
        bindValue = expressable.unwrap()
        expressable.state.listen { _,_ in self.value(expressable.value()) }
        return value(expressable.value())
    }
    
    @discardableResult
    public func minimumValue(_ value: Float) -> Self {
        minimumValue = value
        return self
    }
    
    @discardableResult
    public func minimumValue(_ binding: UIKitPlus.State<Float>) -> Self {
        binding.listen { self.minimumValue($0) }
        return minimumValue(binding.wrappedValue)
    }
    
    @discardableResult
    public func minimumValue<V>(_ expressable: ExpressableState<V, Float>) -> Self {
        expressable.state.listen { _ in self.minimumValue(expressable.value()) }
        return minimumValue(expressable.value())
    }
    
    @discardableResult
    public func maximumValue(_ value: Float) -> Self {
        maximumValue = value
        return self
    }
    
    @discardableResult
    public func maximumValue(_ binding: UIKitPlus.State<Float>) -> Self {
        binding.listen { self.maximumValue($0) }
        return maximumValue(binding.wrappedValue)
    }
    
    @discardableResult
    public func maximumValue<V>(_ expressable: ExpressableState<V, Float>) -> Self {
        expressable.state.listen { _ in self.maximumValue(expressable.value()) }
        return maximumValue(expressable.value())
    }
    
    @discardableResult
    public func minimumValueImage(_ value: UIImage?) -> Self {
        minimumValueImage = value
        return self
    }
    
    @discardableResult
    public func minimumValueImage(_ binding: UIKitPlus.State<UIImage?>) -> Self {
        binding.listen { self.minimumValueImage($0) }
        return minimumValueImage(binding.wrappedValue)
    }
    
    @discardableResult
    public func minimumValueImage<V>(_ expressable: ExpressableState<V, UIImage?>) -> Self {
        expressable.state.listen { _ in self.minimumValueImage(expressable.value()) }
        return minimumValueImage(expressable.value())
    }
    
    @discardableResult
    public func maximumValueImage(_ value: UIImage?) -> Self {
        maximumValueImage = value
        return self
    }
    
    @discardableResult
    public func maximumValueImage(_ binding: UIKitPlus.State<UIImage?>) -> Self {
        binding.listen { self.maximumValueImage($0) }
        return maximumValueImage(binding.wrappedValue)
    }
    
    @discardableResult
    public func maximumValueImage<V>(_ expressable: ExpressableState<V, UIImage?>) -> Self {
        expressable.state.listen { _ in self.maximumValueImage(expressable.value()) }
        return maximumValueImage(expressable.value())
    }
    
    @discardableResult
    public func isContinuous(_ value: Bool = true) -> Self {
        isContinuous = value
        return self
    }
    
    @discardableResult
    public func isContinuous(_ binding: UIKitPlus.State<Bool>) -> Self {
        binding.listen { self.isContinuous($0) }
        return isContinuous(binding.wrappedValue)
    }
    
    @discardableResult
    public func isContinuous<V>(_ expressable: ExpressableState<V, Bool>) -> Self {
        expressable.state.listen { _ in self.isContinuous(expressable.value()) }
        return isContinuous(expressable.value())
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
    public func minimumTrackTintColor(_ binding: UIKitPlus.State<UIColor>) -> Self {
        binding.listen { self.minimumTrackTintColor($0) }
        return minimumTrackTintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func minimumTrackTintColor<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.minimumTrackTintColor(expressable.value()) }
        return minimumTrackTintColor(expressable.value())
    }
    
    @discardableResult
    public func minimumTrackTintColor(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { self.minimumTrackTintColor($0) }
        return minimumTrackTintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func minimumTrackTintColor<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.minimumTrackTintColor(expressable.value()) }
        return minimumTrackTintColor(expressable.value())
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
    public func maximumTrackTintColor(_ binding: UIKitPlus.State<UIColor>) -> Self {
        binding.listen { self.maximumTrackTintColor($0) }
        return maximumTrackTintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func maximumTrackTintColor<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.maximumTrackTintColor(expressable.value()) }
        return maximumTrackTintColor(expressable.value())
    }
    
    @discardableResult
    public func maximumTrackTintColor(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { self.maximumTrackTintColor($0) }
        return maximumTrackTintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func maximumTrackTintColor<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.maximumTrackTintColor(expressable.value()) }
        return maximumTrackTintColor(expressable.value())
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
    public func thumbTintColor(_ binding: UIKitPlus.State<UIColor>) -> Self {
        binding.listen { self.thumbTintColor($0) }
        return thumbTintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func thumbTintColor<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.thumbTintColor(expressable.value()) }
        return thumbTintColor(expressable.value())
    }
    
    @discardableResult
    public func thumbTintColor(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { self.thumbTintColor($0) }
        return thumbTintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func thumbTintColor<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.thumbTintColor(expressable.value()) }
        return thumbTintColor(expressable.value())
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
    public func tintColor(_ binding: UIKitPlus.State<UIColor>) -> Self {
        binding.listen { self.tintColor($0) }
        return tintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func tintColor<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.tintColor(expressable.value()) }
        return tintColor(expressable.value())
    }
    
    @discardableResult
    public func tintColor(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { self.tintColor($0) }
        return tintColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func tintColor<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.tintColor(expressable.value()) }
        return tintColor(expressable.value())
    }
    
    @discardableResult
    public func thumbImage(_ value: UIImage?, for state: UIControl.State = .normal) -> Self {
        setThumbImage(value, for: state)
        return self
    }
    
    @discardableResult
    public func thumbImage(_ binding: UIKitPlus.State<UIImage?>) -> Self {
        binding.listen { self.thumbImage($0) }
        return thumbImage(binding.wrappedValue)
    }
    
    @discardableResult
    public func thumbImage<V>(_ expressable: ExpressableState<V, UIImage?>) -> Self {
        expressable.state.listen { _ in self.thumbImage(expressable.value()) }
        return thumbImage(expressable.value())
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
                bindValue?.wrappedValue = value
            }
            _previousSteppedValue = value
        } else {
            _onChange?(value)
            bindValue?.wrappedValue = value
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
