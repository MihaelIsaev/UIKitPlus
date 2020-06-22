public class ExpressableState<S, Result> where S: Stateable {
    let state: S
    private let _expression: (S.Value) -> Result
    lazy var value: () -> Result = {
        self._expression(self.state.wrappedValue)
    }
    
    init (_ state: S, _ expression: @escaping (S.Value) -> Result) {
        self.state = state
        _expression = expression
    }
    
    public func unwrap() -> State<Result> {
        let state: State<Result> = .init(wrappedValue: self.value())
        self.state.listen { [weak self] _ in
            guard let self = self else { return }
            state.wrappedValue = self.value()
        }
        return state
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

public protocol AnyState {
    func listen(_ listener: @escaping () -> Void)
}

public class AnyStates {
    private let _expression: () -> Void
    lazy var value: () -> Void = {
        self._expression()
    }
    
    @discardableResult
    init (_ states: [AnyState], expression: @escaping () -> Void) {
        _expression = expression
        states.forEach { $0.listen(expression) }
    }
}

extension Array where Element == AnyState {
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        let sss = State<Result>.init(wrappedValue: expression())
        AnyStates(self) {
            sss.wrappedValue = expression()
        }
        return sss
    }
}
