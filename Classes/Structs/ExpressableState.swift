public class ExpressableState<Value, Result> {
    let state: State<Value>
    private let _expression: (Value) -> Result
    lazy var value: () -> Result = {
        self._expression(self.state.wrappedValue)
    }
    
    init (_ state: State<Value>, _ expression: @escaping (Value) -> Result) {
        self.state = state
        _expression = expression
    }
}

extension State {
    public func map<Result>(_ expression: @escaping () -> Result) -> ExpressableState<Value, Result> {
        .init(self) { _ in
            expression()
        }
    }
    
    public func map<Result>(_ expression: @escaping (Value) -> Result) -> ExpressableState<Value, Result> {
        .init(self, expression)
    }
}
