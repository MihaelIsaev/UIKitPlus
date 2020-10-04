public protocol Refreshable {
    func refresh()
}

extension Refreshable {
    // MARK: Reaction on @UState
    
    @discardableResult
    public func react<A>(to a: UState<A>) -> Self {
        a.listen { _,_ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B>(to a: UState<A>, _ b: UState<B>) -> Self {
        a.listen { _,_ in self.refresh() }
        b.listen { _,_ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B, C>(to a: UState<A>, _ b: UState<B>, _ c: UState<C>) -> Self {
        a.listen { _,_ in self.refresh() }
        b.listen { _,_ in self.refresh() }
        c.listen { _,_ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B, C, D>(to a: UState<A>, _ b: UState<B>, _ c: UState<C>, _ d: UState<D>) -> Self {
        a.listen { _,_ in self.refresh() }
        b.listen { _,_ in self.refresh() }
        c.listen { _,_ in self.refresh() }
        d.listen { _,_ in self.refresh() }
        return self
    }
    
    @discardableResult
    public func react<A, B, C, D, E>(to a: UState<A>, _ b: UState<B>, _ c: UState<C>, _ d: UState<D>, _ e: UState<E>) -> Self {
        a.listen { _,_ in self.refresh() }
        b.listen { _,_ in self.refresh() }
        c.listen { _,_ in self.refresh() }
        d.listen { _,_ in self.refresh() }
        e.listen { _,_ in self.refresh() }
        return self
    }
}
