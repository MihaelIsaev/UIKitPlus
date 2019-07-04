import UIKit

class DeclarativePreConstraints {
    typealias RelativeConstraints = [UIView: [NSLayoutConstraint.Attribute: ConstraintValueType]]
    // MARK: Itself
    var solo: [NSLayoutConstraint.Attribute: PreConstraint] = [:]
    // MARK: Relative
    var relative: [NSLayoutConstraint.Attribute: RelativeConstraints] = [:]
    // MARK: SuperView
    var `super`: [NSLayoutConstraint.Attribute: PreConstraint] = [:]
    // MARK: Margin
    var margin: [NSLayoutConstraint.Attribute: CGFloat] = [:]
}
