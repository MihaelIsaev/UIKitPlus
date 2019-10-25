import UIKit

final class TapGestureRecognizer: UITapGestureRecognizer {
    var action: () -> Void

    init(count: Int = 1, _ action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        numberOfTapsRequired = count
        addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}
