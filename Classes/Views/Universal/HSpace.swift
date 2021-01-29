#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, renamed: "UHSpace")
public func HSpace(_ width: CGFloat) -> UView { UHSpace(width) }
@available(*, deprecated, renamed: "UHSpace")
public func HSpace(_ width: State<CGFloat>) -> UView { UHSpace(width) }

public func UHSpace(_ width: CGFloat) -> UView { UView().width(width) }
public func UHSpace(_ width: State<CGFloat>) -> UView { UView().width(width) }
