public class ExpressableState<S, Result> where S: Stateable {
    weak var _leftState: S?
    let _value: () -> Result
    
    init (_ state: S, _ expression: @escaping (S.Value) -> Result) {
        _leftState = state
        _value = { [unowned state] in
            expression(state.wrappedValue)
        }
    }
    
    public func unwrap() -> State<Result> {
        let resultState: State<Result> = .init(wrappedValue: _value())
        self._leftState?.listen { [weak self, weak resultState] in
            guard let self = self else { return }
            resultState?.wrappedValue = self._value()
        }
        return resultState
    }
}

extension Stateable {
    public func map<Result>(_ expression: @escaping () -> Result) -> ExpressableState<Self, Result> {
        .init(self) { _ in
            expression()
        }
    }
    
    public func map<Result>(_ expression: @escaping (Value) -> Result) -> ExpressableState<Self, Result> {
        .init(self, expression)
    }
}

// MARK: Any States to Expressable

public protocol AnyState: class {
    func listen(_ listener: @escaping () -> Void)
}

public class AnyStates {
    private var _expression: (() -> Void)?
    lazy var value: () -> Void = { [weak self] in
        self?._expression?()
    }
    
    @discardableResult
    init (_ states: [AnyState], expression: @escaping () -> Void) {
        _expression = expression
        states.forEach {
            $0.listen { [weak self] in
                self?._expression?()
            }
        }
    }
}

extension Array where Element == AnyState {
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        let state = State<Result>.init(wrappedValue: expression())
        AnyStates(self) {
            state.wrappedValue = expression()
        }
        return state
    }
}
