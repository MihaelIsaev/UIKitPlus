public protocol Stateable: AnyState {
    associatedtype Value
    
    var wrappedValue: Value { get set }
    
    func beginTrigger(_ trigger: @escaping () -> Void)
    func endTrigger(_ trigger: @escaping () -> Void)
    func listen(_ listener: @escaping (_ old: Value, _ new: Value) -> Void)
    func listen(_ listener: @escaping (_ value: Value) -> Void)
    func listen(_ listener: @escaping () -> Void)
}

public typealias UState = State

@propertyWrapper
open class State<Value>: Stateable {
    private var _originalValue: Value
    private var _wrappedValue: Value
    public var wrappedValue: Value {
        get { _wrappedValue }
        set {
            let oldValue = _wrappedValue
            _wrappedValue = newValue
            for trigger in beginTriggers {
                trigger()
            }
            for listener in listeners {
                listener(oldValue, newValue)
            }
            for trigger in endTriggers {
                trigger()
            }
        }
    }
    
    public var projectedValue: State<Value> { self }

    init (_ stateA: AnyState, _ stateB: AnyState, _ expression: @escaping () -> Value) {
        let value = expression()
        _originalValue = value
        _wrappedValue = value
        stateA.listen {// [weak self] in
            self.wrappedValue = expression()
        }
        stateB.listen {// [weak self] in
            self.wrappedValue = expression()
        }
    }
    
    init <A, B>(_ stateA: State<A>, _ stateB: State<B>, _ expression: @escaping (A, B) -> Value) {
        let value = expression(stateA.wrappedValue, stateB.wrappedValue)
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression(stateA.wrappedValue, stateB.wrappedValue)
        }
        stateB.listen {
            self.wrappedValue = expression(stateA.wrappedValue, stateB.wrappedValue)
        }
    }
    
    init <A, B>(_ stateA: State<A>, _ stateB: State<B>, _ expression: @escaping (CombinedDeprecatedResult<A, B>) -> Value) {
        let value = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        }
        stateB.listen {
            self.wrappedValue = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        }
    }
    
    public init(wrappedValue value: Value) {
        _originalValue = value
        _wrappedValue = value
    }
    
    public init <E>(_ expressable: ExpressableState<E, Value>) {
        let initialValue = expressable.value()
        _originalValue = initialValue
        _wrappedValue = initialValue
        expressable.state.listen {
            self.wrappedValue = expressable.value()
        }
    }
    
    public func reset() {
        let oldValue = _wrappedValue
        _wrappedValue = _originalValue
        for trigger in beginTriggers {
            trigger()
        }
        for listener in listeners {
            listener(oldValue, _wrappedValue)
        }
        for trigger in endTriggers {
            trigger()
        }
    }
    
    public func removeAllListeners() {
        beginTriggers.removeAll()
        endTriggers.removeAll()
        listeners.removeAll()
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
        state.listen { [weak self] new in
            guard !justSetInternal else { return }
            justSetExternal = true
            self?.wrappedValue = new
            justSetExternal = false
        }
        self.listen { [weak state] new in
            guard !justSetExternal else { return }
            justSetInternal = true
            state?.wrappedValue = new
            justSetInternal = false
        }
    }
    
    public func and<V>(_ state: State<V>) -> CombinedState<Value, V> {
        CombinedState(left: projectedValue, right: state)
    }
}

public class CombinedState<A, B> {
    let _left: State<A>
    let _right: State<B>
    public var left: A { _left.wrappedValue }
    public var right: B { _right.wrappedValue }
    
    init (left: State<A>, right: State<B>) {
        self._left = left
        self._right = right
    }
    
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        .init(_left, _right, expression)
    }
    
    public func map<Result>(_ expression: @escaping (A, B) -> Result) -> State<Result> {
        .init(_left, _right, expression)
    }
    
    @available(*, deprecated, message: "🧨 This method will be removed soon. Please switch to `.map { left, right in }`.")
    public func map<Result>(_ expression: @escaping (CombinedDeprecatedResult<A, B>) -> Result) -> State<Result> {
        .init(_left, _right, expression)
    }
}

public struct CombinedDeprecatedResult<A, B> {
    public let left: A
    public let right: B
}
