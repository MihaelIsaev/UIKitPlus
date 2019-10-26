import UIKit

public class OuterConstraintValues {
    var declarativeView: UIView
    var collection: DeclarativeConstraintsKeyValueCollection
    
    init (_ declarativeView: UIView, _ collection: DeclarativeConstraintsKeyValueCollection) {
        self.declarativeView = declarativeView
        self.collection = collection
    }
    
    func constraint(_ attribute: NSLayoutConstraint.Attribute, with view: UIView) -> NSLayoutConstraint? {
        guard let dest = view as? DeclarativeProtocolInternal else { return nil }
        guard let inactiveConstraint = collection[attribute]?[view]  else { return nil }
        return dest._properties.constraintsOuter[inactiveConstraint.firstAttribute]?[declarativeView]
    }
    
    public subscript(_ attribute: NSLayoutConstraint.Attribute, _ view: UIView) -> CGFloat? {
        get { constraint(attribute, with: view)?.constant }
        set {
            guard let newValue = newValue else { return }
            constraint(attribute, with: view)?.constant = newValue
        }
    }
}
