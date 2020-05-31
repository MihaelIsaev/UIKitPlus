import UIKit

protocol EditableStackView: class {
    var arrangedSubviews: [UIView] { get }
    func addArrangedSubview(_ view: UIView)
    func add(arrangedView: UIView, at index: Int)
}

extension EditableStackView {
    func add(arrangedView: UIView, at index: Int) {
        let nextViews = arrangedSubviews.dropFirst(index)
        nextViews.forEach { $0.removeFromSuperview() }
        addArrangedSubview(arrangedView)
        nextViews.forEach { self.addArrangedSubview($0) }
    }
}

extension Array where Element == UIView {
    func removeFromSuperview(at indexes: [Int]) {
        guard indexes.count > 0 else { return }
        var filtered: [UIView] = []
        enumerated().forEach { i, v in
            guard indexes.contains(i) else { return }
            filtered.append(v)
        }
        filtered.forEach { $0.removeFromSuperview() }
    }
}
