#if os(macOS)
import AppKit
#else
import UIKit
#endif

public enum PreConstraintView {
    case view(BaseView)
    case tag(Int)
}

public protocol PreConstraintViewable {
    var preConstraintView: PreConstraintView? { get }
}

private extension PreConstraintViewable {
    var box: PreConstraintViewable? {
        switch self.preConstraintView {
        case let .tag(tag): return TagPreConstraintBox(tag)
        case let .view(view): return ViewPreConstraintBox(view)
        default: return nil
        }
    }
}

extension PreConstraintView {
    public func unwrapWithSuperview(_ superview: BaseView) -> BaseView? {
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

extension BaseView: PreConstraintViewable {
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
    weak var fromView: BaseView?
    let value: State<CGFloat>
    let relation: NSLayoutConstraint.Relation
    let multiplier: CGFloat
    let priority: UILayoutPriority
    let attribute1: NSLayoutConstraint.Attribute
    let attribute2: NSLayoutConstraint.Attribute?
    let toSafe: Bool
    var destinationView: PreConstraintViewable? {
        get { _destinationView }
        set { _destinationView = newValue?.box }
    }
    private var _destinationView: PreConstraintViewable?
    var constraint: NSLayoutConstraint?

    init (value: State<CGFloat>,
          relation: NSLayoutConstraint.Relation,
          multiplier: CGFloat,
          priority: UILayoutPriority,
          attribute1: NSLayoutConstraint.Attribute,
          attribute2: NSLayoutConstraint.Attribute?,
          toSafe: Bool,
          fromView: BaseView,
          destinationView: PreConstraintViewable?) {
        self.value = value
        self.relation = relation
        self.multiplier = multiplier
        self.priority = priority
        self.attribute1 = attribute1
        self.attribute2 = attribute2
        self.toSafe = toSafe
        self.fromView = fromView
        self.destinationView = destinationView?.box
        value.listen { [weak self] constant in
            self?.constraint?.constant = constant
            #if os(macOS)
            self?.fromView?.superview?.layoutSubtreeIfNeeded() // TODO: check
            #else
            self?.fromView?.superview?.layoutIfNeeded()
            #endif
        }
    }

    func inverted() -> PreConstraint? {
        guard let attribute2 = attribute2, let destinationView = destinationView?.preConstraintView else { return nil }
        let unwrappedDestinationView: BaseView
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

private struct TagPreConstraintBox: PreConstraintViewable {
    var preConstraintView: PreConstraintView? { .tag(tag) }
    private var tag: Int

    init(_ tag: Int) {
        self.tag = tag
    }
}

private struct ViewPreConstraintBox: PreConstraintViewable {
    var preConstraintView: PreConstraintView? { view.map { .view($0) } }
    private weak var view: BaseView?

    init(_ view: BaseView) {
        self.view = view
    }
}
