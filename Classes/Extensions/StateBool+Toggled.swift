import Foundation


extension State where Value == Bool {
    public var toggled: ExpressableState<State<Value>, Bool> { map { !$0 } }
}
