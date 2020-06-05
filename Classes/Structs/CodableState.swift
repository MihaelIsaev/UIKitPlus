@propertyWrapper
public class CodableState<Value>: Stateable, Codable, Equatable, Hashable where Value: Codable, Value: Hashable {
    public var wrappedValue: Value {
        get { projectedValue.wrappedValue }
        set { projectedValue.wrappedValue = newValue }
    }
    
    public var projectedValue: State<Value>

    public init(wrappedValue value: Value) {
        projectedValue = .init(wrappedValue: value)
    }
    
    required public init (from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Value.self)
        projectedValue = .init(wrappedValue: value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var single = encoder.singleValueContainer()
        try single.encode(wrappedValue)
    }
    
    public func reset() {
        projectedValue.reset()
    }
    
    public func beginTrigger(_ trigger: @escaping State<Value>.Trigger) {
        projectedValue.beginTrigger(trigger)
    }
    
    public func endTrigger(_ trigger: @escaping State<Value>.Trigger) {
        projectedValue.endTrigger(trigger)
    }
    
    public func listen(_ listener: @escaping State<Value>.Listener) {
        projectedValue.listen(listener)
    }
    
    public func listen(_ listener: @escaping State<Value>.SimpleListener) {
        projectedValue.listen(listener)
    }
    
    public func listen(_ listener: @escaping () -> Void) {
        projectedValue.listen(listener)
    }
    
    /// See `Equatable`
    
    public static func == (lhs: CodableState<Value>, rhs: CodableState<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    /// See `Hashable`
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}
