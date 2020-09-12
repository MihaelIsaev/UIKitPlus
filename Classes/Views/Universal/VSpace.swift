#if os(macOS)
import AppKit
#else
import UIKit
#endif

public func VSpace(_ height: CGFloat) -> View { View().height(height) }
public func VSpace(_ height: State<CGFloat>) -> View { View().height(height) }
public func VSpace<V>(_ height: ExpressableState<V, CGFloat>) -> View { View().height(height) }
