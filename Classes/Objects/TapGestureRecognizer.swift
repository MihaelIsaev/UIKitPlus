import UIKit

final class TapGestureRecognizer: UITapGestureRecognizer {
    var action: () -> Void

    init(_ action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}
