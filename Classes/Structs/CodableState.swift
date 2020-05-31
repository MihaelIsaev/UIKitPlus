@propertyWrapper
public class CodableState<Value>: Stateable, Codable, Equatable, Hashable where Value: Codable, Value: Hashable {
    public static func == (lhs: CodableState<Value>, rhs: CodableState<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self._wrappedValue)
    }
    
    private var _originalValue: Value
    private var _wrappedValue: Value
    public var wrappedValue: Value {
        get { _wrappedValue }
        set {
            let oldValue = _wrappedValue
            _wrappedValue = newValue
            beginTriggers.forEach { $0() }
            listeners.forEach { $0(oldValue, newValue) }
            endTriggers.forEach { $0() }
        }
    }
    
    public var projectedValue: CodableState<Value> { self }

    public init(wrappedValue value: Value) {
        _originalValue = value
        _wrappedValue = value
    }
    
    required public init (from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Value.self)
        _originalValue = value
        _wrappedValue = value
    }
    
    public func encode(to encoder: Encoder) throws {
        var single = encoder.singleValueContainer()
        try single.encode(_wrappedValue)
    }
    
    public func reset() {
        let oldValue = _wrappedValue
        _wrappedValue = _originalValue
        beginTriggers.forEach { $0() }
        listeners.forEach { $0(oldValue, _wrappedValue) }
        endTriggers.forEach { $0() }
    }
    
    public typealias Trigger = () -> Void
    public typealias Listener = (_ old: Value, _ new: Value) -> Void
    public typealias SimpleListener = (_ value: Value) -> Void
    
    private var beginTriggers: [Trigger] = []
    private var endTriggers: [Trigger] = []
    private var listeners: [Listener] = []
    
    public func beginTrigger(_ trigger: @escaping Trigger) {
        beginTriggers.append(trigger)
    }
    
    public func endTrigger(_ trigger: @escaping Trigger) {
        endTriggers.append(trigger)
    }
    
    public func listen(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
    
    public func listen(_ listener: @escaping SimpleListener) {
        listeners.append({ _, new in listener(new) })
    }
    
    public func listen(_ listener: @escaping () -> Void) {
        listeners.append({ _,_ in listener() })
    }
    
    public func merge(with state: State<Value>) {
        self.wrappedValue = state.wrappedValue
        var justSetExternal = false
        var justSetInternal = false
        state.listen { new in
            guard !justSetInternal else { return }
            justSetExternal = true
            self.wrappedValue = new
            justSetExternal = false
        }
        self.listen { new in
            guard !justSetExternal else { return }
            justSetInternal = true
            state.wrappedValue = new
            justSetInternal = false
        }
    }
}
