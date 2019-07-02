import UIKit

extension DeclarativeProtocol {
    public func shake(values: [CGFloat] = [-20, 20, -20, 20, -10, 10, -5, 5, 0],
                      duration: CFTimeInterval = 0.6,
                      axis: NSLayoutConstraint.Axis = .horizontal,
                      timing: CAMediaTimingFunctionName = .linear) {
        let animation = CAKeyframeAnimation(keyPath: axis == .horizontal ? "transform.translation.x" : "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: timing)
        animation.duration = duration
        animation.values = values
        declarativeView.layer.add(animation, forKey: "shake")
    }
    
    public func shake(_ values: CGFloat...,
                      duration: CFTimeInterval = 0.6,
                      axis: NSLayoutConstraint.Axis = .horizontal,
                      timing: CAMediaTimingFunctionName = .linear) {
        shake(values: values, duration: duration, axis: axis, timing: timing)
    }
}
