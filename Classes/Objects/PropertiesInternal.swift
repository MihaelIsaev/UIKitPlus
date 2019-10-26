import UIKit

public class PropertiesInternal {
    var circleCorners: Bool = false
    var customCorners: CustomCorners?
    lazy var borders = Borders()
    
    // MARK: - Internal Constraints
    
    var notAppliedPreConstraintsSuper: [PreConstraint] = []
    var appliedPreConstraintsSuper: [PreConstraint] = []
    
    var notAppliedPreConstraintsSolo: [PreConstraint] = []
    var appliedPreConstraintsSolo: [PreConstraint] = []
    
    var notAppliedPreConstraintsRelative: [PreConstraint] = []
    var appliedPreConstraintsRelative: [PreConstraint] = []
}
