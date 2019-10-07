import UIKit

open class PickerView: UIPickerView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: PickerView { self }
    public lazy var properties = Properties<PickerView>()
    lazy var _properties = PropertiesInternal()
    
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
}

extension PickerView: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _changed(row, component)
    }
}
