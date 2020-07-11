import UIKit
#if os(iOS)
public typealias UDatePicker = DatePicker
open class DatePicker: UIDatePicker, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: DatePicker { self }
    public lazy var properties = Properties<DatePicker>()
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
        binding.listen { self.textColor($0) }
        return textColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func textColor<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.textColor(expressable.value()) }
        return textColor(expressable.value())
    }
    
    @discardableResult
    public func textColor(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { self.textColor($0) }
        return textColor(binding.wrappedValue)
    }
    
    @discardableResult
    public func textColor<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.textColor(expressable.value()) }
        return textColor(expressable.value())
    }
    
    // MARK: Mode
    
    @discardableResult
    public func mode(_ value: UIDatePicker.Mode) -> Self {
        datePickerMode = value
        return self
    }
    
    @discardableResult
    public func mode(_ binding: UIKitPlus.State<UIDatePicker.Mode>) -> Self {
        binding.listen { self.mode($0) }
        return mode(binding.wrappedValue)
    }
    
    @discardableResult
    public func mode<V>(_ expressable: ExpressableState<V, UIDatePicker.Mode>) -> Self {
        expressable.state.listen { _ in self.mode(expressable.value()) }
        return mode(expressable.value())
    }
    
    // MARK: Locale
    
    @discardableResult
    public func locale(_ value: Locale) -> Self {
        locale = value
        return self
    }
    
    @discardableResult
    public func locale(_ binding: UIKitPlus.State<Locale>) -> Self {
        binding.listen { self.locale($0) }
        return locale(binding.wrappedValue)
    }
    
    @discardableResult
    public func locale<V>(_ expressable: ExpressableState<V, Locale>) -> Self {
        expressable.state.listen { _ in self.locale(expressable.value()) }
        return locale(expressable.value())
    }
    
    // MARK: Calendar
    
    @discardableResult
    public func calendar(_ value: Calendar) -> Self {
        calendar = value
        return self
    }
    
    @discardableResult
    public func calendar(_ binding: UIKitPlus.State<Calendar>) -> Self {
        binding.listen { self.calendar($0) }
        return calendar(binding.wrappedValue)
    }
    
    @discardableResult
    public func calendar<V>(_ expressable: ExpressableState<V, Calendar>) -> Self {
        expressable.state.listen { _ in self.calendar(expressable.value()) }
        return calendar(expressable.value())
    }
    
    // MARK: TimeZone
    
    @discardableResult
    public func timeZone(_ value: TimeZone) -> Self {
        timeZone = value
        return self
    }
    
    @discardableResult
    public func timeZone(_ binding: UIKitPlus.State<TimeZone>) -> Self {
        binding.listen { self.timeZone($0) }
        return timeZone(binding.wrappedValue)
    }
    
    @discardableResult
    public func timeZone<V>(_ expressable: ExpressableState<V, TimeZone>) -> Self {
        expressable.state.listen { _ in self.timeZone(expressable.value()) }
        return timeZone(expressable.value())
    }
    
    // MARK: Date
    
    @discardableResult
    public func date(_ value: Date, animated: Bool = false) -> Self {
        setDate(value, animated: animated)
        return self
    }
    
    var dateBinding: UIKitPlus.State<Date>?
    
    @discardableResult
    public func date(_ binding: UIKitPlus.State<Date>, animated: Bool = false) -> Self {
        dateBinding = binding
        binding.listen { self.date($0, animated: animated) }
        return date(binding.wrappedValue)
    }
    
    @discardableResult
    public func date<V>(_ expressable: ExpressableState<V, Date>, animated: Bool = false) -> Self {
        return date(expressable.unwrap(), animated: animated)
    }
    
    // MARK: Minimum Date
    
    @discardableResult
    public func minimumDate(_ value: Date) -> Self {
        minimumDate = value
        return self
    }
    
    @discardableResult
    public func minimumDate(_ binding: UIKitPlus.State<Date>) -> Self {
        binding.listen { self.minimumDate($0) }
        return minimumDate(binding.wrappedValue)
    }
    
    @discardableResult
    public func minimumDate<V>(_ expressable: ExpressableState<V, Date>) -> Self {
        expressable.state.listen { _ in self.minimumDate(expressable.value()) }
        return minimumDate(expressable.value())
    }
    
    // MARK: Maximum Date
    
    @discardableResult
    public func maximumDate(_ value: Date) -> Self {
        maximumDate = value
        return self
    }
    
    @discardableResult
    public func maximumDate(_ binding: UIKitPlus.State<Date>) -> Self {
        binding.listen { self.maximumDate($0) }
        return maximumDate(binding.wrappedValue)
    }
    
    @discardableResult
    public func maximumDate<V>(_ expressable: ExpressableState<V, Date>) -> Self {
        expressable.state.listen { _ in self.maximumDate(expressable.value()) }
        return maximumDate(expressable.value())
    }
    
    // MARK: Countdown Duration
    
    @discardableResult
    public func countDownDuration(_ value: TimeInterval) -> Self {
        countDownDuration = value
        return self
    }
    
    @discardableResult
    public func countDownDuration(_ binding: UIKitPlus.State<TimeInterval>) -> Self {
        binding.listen { self.countDownDuration($0) }
        return countDownDuration(binding.wrappedValue)
    }
    
    @discardableResult
    public func countDownDuration<V>(_ expressable: ExpressableState<V, TimeInterval>) -> Self {
        expressable.state.listen { _ in self.countDownDuration(expressable.value()) }
        return countDownDuration(expressable.value())
    }
    
    // MARK: Minute Interval
    
    @discardableResult
    public func minuteInterval(_ value: Int) -> Self {
        minuteInterval = value
        return self
    }
    
    @discardableResult
    public func minuteInterval(_ binding: UIKitPlus.State<Int>) -> Self {
        binding.listen { self.minuteInterval($0) }
        return minuteInterval(binding.wrappedValue)
    }
    
    @discardableResult
    public func minuteInterval<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.minuteInterval(expressable.value()) }
        return minuteInterval(expressable.value())
    }
    
    // MARK: Handler
    
    private var _changed: (Date) -> Void = { _ in }
    
    @objc
    private func changed() {
        dateBinding?.wrappedValue = date
        _changed(date)
    }
    
    @discardableResult
    public func onChange(_ closure: @escaping (Date) -> Void) -> Self {
        _changed = closure
        return self
    }
}
#endif
