import UIKit

extension WrappedViewControllerable {
    public func hidden(_ hidden: Bool = true) {
        guard hidden == !protocolView.isHidden else { return }
        protocolView.hidden(hidden)
        if hidden {
            protocolController.viewWillDisappear(false)
            protocolController.viewDidDisappear(false)
        } else {
            protocolController.viewWillAppear(false)
            protocolController.viewDidAppear(false)
        }
    }
}
