public class ExpressableState<S, Result> where S: Stateable {
    let state: S
    let value: () -> Result
    
    init (_ state: S, _ expression: @escaping (S.Value) -> Result) {
        self.state = state
        value = {// [unowned state] in
            expression(state.wrappedValue)
        }
    }
    
    public func unwrap() -> State<Result> {
        .init(self)
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
    
    @discardableResult
    init (_ states: [AnyState], expression: @escaping () -> Void) {
        _expression = expression
        for state in states {
            state.listen { [weak self] in
                self?._expression?()
            }
        }
    }
}

extension Array where Element == AnyState {
    public func map<Result>(_ expression: @escaping () -> Result) -> State<Result> {
        let state = State<Result>.init(wrappedValue: expression())
        AnyStates(self) { [weak state] in
            state?.wrappedValue = expression()
        }
        return state
    }
}
