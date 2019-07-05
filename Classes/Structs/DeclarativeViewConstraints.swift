import UIKit

public class DeclarativeViewConstraints {
    var _declarativeView: DeclarativeProtocolInternal
    var declarativeView: UIView
    
    init (_ _declarativeView: DeclarativeProtocolInternal, _ declarativeView: UIView) {
        self._declarativeView = _declarativeView
        self.declarativeView = declarativeView
    }
    
    public var width: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.width] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .width) }
    }
    
    public var height: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.height] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .height) }
    }
    
    public var top: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.top] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .top) }
    }
    
    public var leading: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.leading] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .leading) }
    }
    
    public var trailing: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.trailing] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .trailing) }
    }
    
    public var bottom: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.bottom] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .bottom) }
    }
    
    public var centerX: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.centerX] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .centerX) }
    }
    
    public var centerY: NSLayoutConstraint? {
        get { return _declarativeView._constraintsMain[.centerY] }
        set { _declarativeView._constraintsMain.setValue(newValue, for: .centerY) }
    }
    
    public var outer: OuterConstraints { return .init(declarativeView, _declarativeView._constraintsOuter) }
}
