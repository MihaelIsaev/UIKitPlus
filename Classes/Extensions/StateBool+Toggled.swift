import Foundation


extension UState where Value == Bool {
    public var toggled: ExpressableState<UState<Value>, Bool> { map { !$0 } }
}
