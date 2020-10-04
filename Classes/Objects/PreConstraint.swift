import UIKit

public enum PreConstraintView {
    case view(UIView)
    case tag(Int)
}

public protocol PreConstraintViewable {
    var preConstraintView: PreConstraintView? { get }
}

extension PreConstraintView {
    public func unwrapWithSuperview(_ superview: UIView) -> UIView? {
        switch self {
        case .view(let view):
            return view
        case .tag(let tag):
            return superview.viewWithTagInSuperview(tag)
        }
    }
    
    public var tag: Int? {
        switch self {
        case .view:
            return nil
        case .tag(let tag):
            return tag
        }
    }
}

extension UIView: PreConstraintViewable {
    public var preConstraintView: PreConstraintView? {
        .view(self)
    }
}

extension Int: PreConstraintViewable {
    public var preConstraintView: PreConstraintView? {
        .tag(self)
    }
}

class PreConstraint: Equatable {
    static func == (lhs: PreConstraint, rhs: PreConstraint) -> Bool {
        lhs.id == rhs.id
    }
    
    private let id = UUID()
    weak var fromView: UIView?
    let value: UState<CGFloat>
    let relation: NSLayoutConstraint.Relation
    let multiplier: CGFloat
    let priority: UILayoutPriority
    let attribute1: NSLayoutConstraint.Attribute
    let attribute2: NSLayoutConstraint.Attribute?
    let toSafe: Bool
    var destinationView: PreConstraintViewable?
    var constraint: NSLayoutConstraint?
    
    init (value: UState<CGFloat>,
          relation: NSLayoutConstraint.Relation,
          multiplier: CGFloat,
          priority: UILayoutPriority,
          attribute1: NSLayoutConstraint.Attribute,
          attribute2: NSLayoutConstraint.Attribute?,
          toSafe: Bool,
          fromView: UIView,
          destinationView: PreConstraintViewable?) {
        self.value = value
        self.relation = relation
        self.multiplier = multiplier
        self.priority = priority
        self.attribute1 = attribute1
        self.attribute2 = attribute2
        self.toSafe = toSafe
        self.fromView = fromView
        self.destinationView = destinationView
        value.listen { [weak self] constant in
            self?.constraint?.constant = constant
            self?.fromView?.superview?.layoutIfNeeded()
        }
    }
    
    func inverted() -> PreConstraint? {
        guard let attribute2 = attribute2, let destinationView = destinationView?.preConstraintView else { return nil }
        let unwrappedDestinationView: UIView
        switch destinationView {
        case .view(let v):
            unwrappedDestinationView = v
        default:
            return nil
        }
        return PreConstraint(value: value,
                  relation: relation,
                  multiplier: multiplier,
                  priority: priority,
                  attribute1: attribute2,
                  attribute2: attribute1,
                  toSafe: toSafe,
                  fromView: unwrappedDestinationView,
                  destinationView: fromView)
    }
}
