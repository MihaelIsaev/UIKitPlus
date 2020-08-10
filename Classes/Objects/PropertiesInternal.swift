#if os(macOS)
import AppKit
#else
import UIKit
#endif

public class PropertiesInternal {
    var circleCorners: Bool = false
    #if !os(macOS)
    var customCorners: CustomCorners?
    #endif
    lazy var borders = Borders()
    #if !os(macOS)
    var textChangeTransition: UIView.AnimationOptions?
    #endif
    var stateString: StateStringBuilder.Handler?
    var stateAttrString: StateAttrStringBuilder.Handler?
    
    var textBinding: State<String>?
    
    @State var isTyping = false
    var isTypingState: State<Bool> { _isTyping }
    
    var typingInterval: TimeInterval = 0.5
    var typingTimer: Timer?
    
    @State var placeholderText: String?
    var placeholderAttrText: NSMutableAttributedString?
    var generatedPlaceholderString: NSAttributedString?
    
    // MARK: - Internal Constraints
    
    var notAppliedPreConstraintsSuper: [PreConstraint] = []
    var appliedPreConstraintsSuper: [PreConstraint] = []
    
    var notAppliedPreConstraintsSolo: [PreConstraint] = []
    var appliedPreConstraintsSolo: [PreConstraint] = []
    
    var notAppliedPreConstraintsRelative: [PreConstraint] = []
    var appliedPreConstraintsRelative: [PreConstraint] = []
    
    func moveAppliedToNotApplied() {
        appliedPreConstraintsSuper.forEach {
            $0.value.removeAllListeners()
            notAppliedPreConstraintsSuper.append($0)
        }
        appliedPreConstraintsSuper.removeAll()
    }
}
