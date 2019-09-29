@propertyWrapper
public class State<Value> {
    private var _wrappedValue: Value
    public var wrappedValue: Value {
        get { _wrappedValue }
        set {
            _wrappedValue = newValue
            listeners.forEach { $0(newValue) }
        }
    }
    
    public var projectedValue: State<Value> {
        return self
    }

    public init(initialValue value: Value) {
        _wrappedValue = value
    }
    
    public typealias Listener = (Value) -> Void
    
    private var listeners: [Listener] = []
    
    public func listen(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
}
