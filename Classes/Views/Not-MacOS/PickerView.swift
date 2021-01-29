#if !os(macOS)
import UIKit
#if !os(tvOS)

@available(*, deprecated, renamed: "UPickerView")
public typealias PickerView = UPickerView

open class UPickerView: UIPickerView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: UPickerView { self }
    public lazy var properties = Properties<UPickerView>()
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
    
    @discardableResult
    public func delegate(_ value: UIPickerViewDelegate) -> Self {
        delegate = value
        return self
    }
    
    @discardableResult
    public func dataSource(_ value: UIPickerViewDataSource) -> Self {
        dataSource = value
        return self
    }
    
    // MARK: Handler
    
    private var _changed: (Int, Int) -> Void = { _,_ in }
    
    @discardableResult
    public func onChange(_ closure: @escaping (Int, Int) -> Void) -> Self {
        _changed = closure
        return self
    }
    
    // MARK: TextColor
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        setValue(color, forKey: "textColor")
        return self
    }
    
    @discardableResult
    public func textColor(_ hex: Int) -> Self {
        textColor(hex.color)
    }
    
    @discardableResult
    public func textColor(_ binding: UIKitPlus.State<UIColor>) -> Self {
        binding.listen { [weak self] in self?.textColor($0) }
        return textColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func textColor(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { [weak self] in self?.textColor($0) }
        return textColor(binding.wrappedValue)
    }
}

extension PickerView: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _changed(row, component)
    }
}
#endif
#endif
