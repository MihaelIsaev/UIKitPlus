import UIKit

public struct DeclarativeViewConstraints {
    var declarativeView: DeclarativeProtocolInternal
    
    init (_ declarativeView: DeclarativeProtocolInternal) {
        self.declarativeView = declarativeView
    }
    
    public var width: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.width] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .width) }
    }
    
    public var height: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.height] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .height) }
    }
    
    public var top: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.top] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .top) }
    }
    
    public var leading: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.leading] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .leading) }
    }
    
    public var trailing: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.trailing] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .trailing) }
    }
    
    public var bottom: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.bottom] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .bottom) }
    }
    
    public var centerX: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.centerX] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .centerX) }
    }
    
    public var centerY: NSLayoutConstraint? {
        get { return declarativeView._constraintsMain[.centerY] }
        set { declarativeView._constraintsMain.setValue(newValue, for: .centerY) }
    }
    
    public func outer(_ attribute: NSLayoutConstraint.Attribute, withView view: UIView) -> NSLayoutConstraint? {
        return declarativeView._constraintsOuter[attribute]?[view]
    }
}
