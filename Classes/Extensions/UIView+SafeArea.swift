import UIKit

extension UIView {
    public var safeInsets: UIEdgeInsets {
        var insets = UIEdgeInsets()
        if #available(iOS 11.0, *) {
            insets.top = safeAreaInsets.top
        }
        if #available(iOS 11.0, *) {
            insets.left = safeAreaInsets.left
        }
        if #available(iOS 11.0, *) {
            insets.right = safeAreaInsets.right
        }
        if #available(iOS 11.0, *) {
            insets.bottom = safeAreaInsets.bottom
        }
        return insets
    }
    
    public class SafeAnchors {
        let view: UIView
        
        init (_ view: UIView) {
            self.view = view
        }
        
        public var leadingAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.leadingAnchor
            }
            return view.leadingAnchor
        }
        
        public var trailingAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.trailingAnchor
            }
            return view.trailingAnchor
        }
        
        public var leftAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.leftAnchor
            }
            return view.leftAnchor
        }
        
        public var rightAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.rightAnchor
            }
            return view.rightAnchor
        }
        
        public var topAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.topAnchor
            }
            return view.topAnchor
        }
        
        public var bottomAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.bottomAnchor
            }
            return view.bottomAnchor
        }
        
        public var widthAnchor: NSLayoutDimension {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.widthAnchor
            }
            return view.widthAnchor
        }
        
        public var heightAnchor: NSLayoutDimension {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.heightAnchor
            }
            return view.heightAnchor
        }
        
        public var centerXAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.centerXAnchor
            }
            return view.centerXAnchor
        }
        
        public var centerYAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, *) {
                return view.safeAreaLayoutGuide.centerYAnchor
            }
            return view.centerYAnchor
        }
    }
    
    public var safeArea: SafeAnchors { return .init(self) }
}
