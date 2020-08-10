#if os(macOS)
import AppKit

extension NSLayoutConstraint {
    public typealias Axis = Orientation
}
#else
import UIKit
#endif



extension BaseView {
    public func shake(values: [CGFloat] = [-20, 20, -20, 20, -10, 10, -5, 5, 0],
                      duration: CFTimeInterval = 0.6,
                      axis: NSLayoutConstraint.Axis = .horizontal,
                      timing: CAMediaTimingFunctionName = .linear) {
        let animation = CAKeyframeAnimation(keyPath: axis == .horizontal ? "transform.translation.x" : "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: timing)
        animation.duration = duration
        animation.values = values
        #if os(macOS)
        layer?.add(animation, forKey: "shake")
        #else
        layer.add(animation, forKey: "shake")
        #endif
    }
    
    public func shake(_ values: CGFloat...,
                      duration: CFTimeInterval = 0.6,
                      axis: NSLayoutConstraint.Axis = .horizontal,
                      timing: CAMediaTimingFunctionName = .linear) {
        shake(values: values, duration: duration, axis: axis, timing: timing)
    }
}
