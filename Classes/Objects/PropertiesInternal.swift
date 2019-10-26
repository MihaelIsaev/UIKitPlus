import UIKit

public class PropertiesInternal {
    var circleCorners: Bool = false
    var customCorners: CustomCorners?
    lazy var borders = Borders()
    
    var preConstraints = DeclarativePreConstraints()
    var constraintsMain: DeclarativeConstraintsCollection = [:]
    var constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
    // MARK: - new constraints
    
    class PC: Equatable {
        static func == (lhs: PropertiesInternal.PC, rhs: PropertiesInternal.PC) -> Bool {
            lhs.id == rhs.id
        }
        
        private let id = UUID()
        weak var fromView: UIView?
        let value: State<CGFloat>
        let relation: NSLayoutConstraint.Relation
        let multiplier: CGFloat
        let priority: UILayoutPriority
        let attribute1: NSLayoutConstraint.Attribute
        let attribute2: NSLayoutConstraint.Attribute?
        let toSafe: Bool
        weak var destinationView: UIView?
        var constraint: NSLayoutConstraint?
        
        init (value: State<CGFloat>,
              relation: NSLayoutConstraint.Relation,
              multiplier: CGFloat,
              priority: UILayoutPriority,
              attribute1: NSLayoutConstraint.Attribute,
              attribute2: NSLayoutConstraint.Attribute?,
              toSafe: Bool,
              fromView: UIView,
              destinationView: UIView?) {
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
    }
    
    var notAppliedPreConstraintsSuper: [PC] = []
    var appliedPreConstraintsSuper: [PC] = []
    
    var notAppliedPreConstraintsSolo: [PC] = []
    var appliedPreConstraintsSolo: [PC] = []
    
    var notAppliedPreConstraintsRelative: [PC] = []
    var appliedPreConstraintsRelative: [PC] = []
}
