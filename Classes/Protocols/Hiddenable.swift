#if os(macOS)
import AppKit
#else
import UIKit
#endif

protocol Hiddenable {
    var hiddenState: State<Bool> { get }
}
