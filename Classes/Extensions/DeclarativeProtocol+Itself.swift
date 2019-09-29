extension DeclarativeProtocol {
    public func itself(_ itself: inout Self?) -> Self {
        itself = self
        return self
    }
}
