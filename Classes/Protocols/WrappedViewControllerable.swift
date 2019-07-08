import UIKit

public protocol WrappedViewControllerable {
    var protocolView: View { get }
    var protocolController: UIViewController { get }
}
