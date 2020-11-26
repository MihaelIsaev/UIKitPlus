import UIKit

public class PropertiesInternal {
    var circleCorners: Bool = false
    var customCorners: CustomCorners?
    lazy var borders = Borders()
    var textChangeTransition: UIView.AnimationOptions?
    var stateString: StateStringBuilder.Handler?
    var stateAttrString: StateAttrStringBuilder.Handler?
    
    var textBinding: UState<String>?
    
    @UState var isTyping = false
    var isTypingState: UState<Bool> { _isTyping }
    
    var typingInterval: TimeInterval = 0.5
    var typingTimer: Timer?
    
    @UState var placeholderText: String?
    var placeholderAttrText: NSMutableAttributedString?
    var generatedPlaceholderString: NSAttributedString?
    
    // MARK: - Internal Constraints
    
    var notAppliedPreConstraintsSuper: [PreConstraint] = []
    var appliedPreConstraintsSuper: [PreConstraint] = []
    
    var notAppliedPreConstraintsSolo: [PreConstraint] = []
    var appliedPreConstraintsSolo: [PreConstraint] = []
    
    var notAppliedPreConstraintsRelative: [PreConstraint] = []
    var appliedPreConstraintsRelative: [PreConstraint] = []
}
