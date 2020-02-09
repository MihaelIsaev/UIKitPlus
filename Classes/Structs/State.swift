public protocol Stateable: AnyState {
    associatedtype Value
    
    var wrappedValue: Value { get set }
    
    func listen(_ listener: @escaping (_ old: Value, _ new: Value) -> Void)
    func listen(_ listener: @escaping (_ value: Value) -> Void)
    func listen(_ listener: @escaping () -> Void)
}

@propertyWrapper
public class State<Value>: Stateable {
    private var _originalValue: Value
    private var _wrappedValue: Value
    public var wrappedValue: Value {
        get { _wrappedValue }
        set {
            let oldValue = _wrappedValue
            _wrappedValue = newValue
            listeners.forEach { $0(oldValue, newValue) }
        }
    }
    
    public var projectedValue: State<Value> { self }

    public init(wrappedValue value: Value) {
        _originalValue = value
        _wrappedValue = value
    }
    
    public func reset() {
        let oldValue = _wrappedValue
        _wrappedValue = _originalValue
        listeners.forEach { $0(oldValue, _wrappedValue) }
    }
    
    public typealias Listener = (_ old: Value, _ new: Value) -> Void
    public typealias SimpleListener = (_ value: Value) -> Void
    
    private var listeners: [Listener] = []
    
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
    
    // MARK: Experimental part
    
    public struct CombinedStateResult<A, B> {
        public let left: A
        public let right: B
    }
    
    /// Merging two states into one combined state which could be used as expressable state
    public func and<V>(_ state: State<V>) -> State<CombinedStateResult<Value, V>> {
        let stateA = self
        let stateB = state
        var combinedValue = {
            return CombinedStateResult(left: stateA.wrappedValue, right: stateB.wrappedValue)
        }
        let resultState = State<CombinedStateResult<Value, V>>(wrappedValue: combinedValue())
        stateA.listen {
            resultState.wrappedValue = combinedValue()
        }
        stateB.listen {
            resultState.wrappedValue = combinedValue()
        }
        return resultState
    }
}
}
