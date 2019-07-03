import UIKit

extension UIVisualEffect {
    public static var darkBlur: UIVisualEffect { return UIBlurEffect(style: .dark) }
    public static var lightBlur: UIVisualEffect { return UIBlurEffect(style: .light) }
    public static var extraLightBlur: UIVisualEffect { return UIBlurEffect(style: .extraLight) }
    @available(iOS 10.0, *)
    public static var prominentBlur: UIVisualEffect { return UIBlurEffect(style: .prominent) }
    @available(iOS 10.0, *)
    public static var regularBlur: UIVisualEffect { return UIBlurEffect(style: .regular) }
}
