import UIKit

open class DatePicker: UIDatePicker, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: DatePicker { self }
    public lazy var properties = Properties<DatePicker>()
    lazy var _properties = PropertiesInternal()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(changed), for: .valueChanged)
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
    public func textColor(_ color: UIColor) -> Self {
        setValue(color, forKey: "textColor")
        return self
    }
    
    @discardableResult
    public func textColor(_ hex: Int) -> Self {
        textColor(hex.color)
    }
    
    @discardableResult
    public func mode(_ value: UIDatePicker.Mode) -> Self {
        datePickerMode = value
        return self
    }
    
    @discardableResult
    public func locale(_ value: Locale) -> Self {
        locale = value
        return self
    }
    
    @discardableResult
    public func calendar(_ value: Calendar) -> Self {
        calendar = value
        return self
    }
    
    @discardableResult
    public func timeZone(_ value: TimeZone) -> Self {
        timeZone = value
        return self
    }
    
    @discardableResult
    public func date(_ value: Date) -> Self {
        date = value
        return self
    }
    
    @discardableResult
    public func minimumDate(_ value: Date) -> Self {
        minimumDate = value
        return self
    }
    
    @discardableResult
    public func maximumDate(_ value: Date) -> Self {
        maximumDate = value
        return self
    }
    
    @discardableResult
    public func countDownDuration(_ value: TimeInterval) -> Self {
        countDownDuration = value
        return self
    }
    
    @discardableResult
    public func minuteInterval(_ value: Int) -> Self {
        minuteInterval = value
        return self
    }
    
    // MARK: Handler
    
    private var _changed: (Date) -> Void = { _ in }
    
    @objc
    private func changed() {
        _changed(date)
    }
    
    @discardableResult
    public func onChange(_ closure: @escaping (Date) -> Void) -> Self {
        _changed = closure
        return self
    }
}
