import UIKit

public struct DeclarativeViewConstraints {
    var declarativeView: DeclarativeProtocolInternal
    
    init (_ declarativeView: DeclarativeProtocolInternal) {
        self.declarativeView = declarativeView
    }
    
    public var width: NSLayoutConstraint? {
        get { return declarativeView._constraints[.width] }
        set { declarativeView._constraints.setValue(newValue, for: .width) }
    }
    
    public var height: NSLayoutConstraint? {
        get { return declarativeView._constraints[.height] }
        set { declarativeView._constraints.setValue(newValue, for: .height) }
    }
    
    public var top: NSLayoutConstraint? {
        get { return declarativeView._constraints[.top] }
        set { declarativeView._constraints.setValue(newValue, for: .top) }
    }
    
    public var leading: NSLayoutConstraint? {
        get { return declarativeView._constraints[.leading] }
        set { declarativeView._constraints.setValue(newValue, for: .leading) }
    }
    
    public var trailing: NSLayoutConstraint? {
        get { return declarativeView._constraints[.trailing] }
        set { declarativeView._constraints.setValue(newValue, for: .trailing) }
    }
    
    public var bottom: NSLayoutConstraint? {
        get { return declarativeView._constraints[.bottom] }
        set { declarativeView._constraints.setValue(newValue, for: .bottom) }
    }
    
    public var centerX: NSLayoutConstraint? {
        get { return declarativeView._constraints[.centerX] }
        set { declarativeView._constraints.setValue(newValue, for: .centerX) }
    }
    
    public var centerY: NSLayoutConstraint? {
        get { return declarativeView._constraints[.centerY] }
        set { declarativeView._constraints.setValue(newValue, for: .centerY) }
    }
}
