#if os(macOS)
import AppKit
#else
import UIKit
#endif

public func HSpace(_ width: CGFloat) -> View { View().width(width) }
public func HSpace(_ width: State<CGFloat>) -> View { View().width(width) }
public func HSpace<V>(_ width: ExpressableState<V, CGFloat>) -> View { View().width(width) }
