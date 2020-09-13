#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, renamed: "UVSpace")
public func VSpace(_ height: CGFloat) -> UView { UVSpace(height) }
@available(*, deprecated, renamed: "UVSpace")
public func VSpace(_ height: State<CGFloat>) -> UView { UVSpace(height) }
@available(*, deprecated, renamed: "UVSpace")
public func VSpace<V>(_ height: ExpressableState<V, CGFloat>) -> UView { UVSpace(height) }

public func UVSpace(_ height: CGFloat) -> UView { UView().height(height) }
public func UVSpace(_ height: State<CGFloat>) -> UView { UView().height(height) }
public func UVSpace<V>(_ height: ExpressableState<V, CGFloat>) -> UView { UView().height(height) }
