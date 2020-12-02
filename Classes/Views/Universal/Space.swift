#if os(macOS)
import AppKit
#else
import UIKit
#endif

@available(*, deprecated, renamed: "USpace")
public func Space() -> UView { USpace() }

public func USpace() -> UView { UView() }
