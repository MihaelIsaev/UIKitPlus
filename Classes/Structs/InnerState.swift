@propertyWrapper
public class InnerState<Value, InnerValue> {
    private var _keyPath: WritableKeyPath<Value, InnerValue>
    private var _wrappedValue: State<Value>
    public var wrappedValue: InnerValue {
        get { _wrappedValue.wrappedValue[keyPath: _keyPath] }
        set {
            let oldValue = _wrappedValue.wrappedValue[keyPath: _keyPath]
            _wrappedValue.wrappedValue[keyPath: _keyPath] = newValue
            listeners.forEach { $0(oldValue, newValue) }
        }
    }
    
    @State
    var innerState: InnerValue

    public var projectedValue: State<InnerValue> { $innerState }

    public init(_ value: State<Value>, _ keyPath: WritableKeyPath<Value, InnerValue>) {
        _wrappedValue = value
        _keyPath = keyPath
        innerState = _wrappedValue.wrappedValue[keyPath: keyPath]
        value.listen { [weak self] oldValue, newValue in
            self?.innerState = newValue[keyPath: keyPath]
        }
        $innerState.listen { [weak self] oldValue, newValue in
            guard let self = self else { return }
            self.listeners.forEach { $0(oldValue, newValue) }
        }
    }

    public typealias Listener = (_ old: InnerValue, _ new: InnerValue) -> Void
    public typealias SimpleListener = (_ value: InnerValue) -> Void

    private var listeners: [Listener] = []

    public func listen(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
    
    public func listen(_ listener: @escaping SimpleListener) {
        listeners.append({ _, new in listener(new) })
    }
}
