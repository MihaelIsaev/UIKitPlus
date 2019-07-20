import UIKit

extension UIDevice {
    public enum ScreenMaxWidth: Float {
        case iPhone4        = 480 // 320 480
        case iPhone5        = 568 // 320 568
        case iPhone6        = 667 // screen size: (375.0, 667.0)
        case iPhone6Plus  = 736 //screen size: (414.0, 736.0)
        case iPhoneX        = 812 // X & XS screen size: (375.0, 812.0)
        case iPhoneXMax  = 896 // XSMax & XR screen size: (414.0, 896.0)
        case iPad             = 1024 // screen size: (768.0, 1024.0)
        case iPad10_5      = 1112 //screen size: (834.0, 1112.0)
        case iPad11          = 1194 // screen size: (834.0, 1194.0)
        case iPad12_9      = 1366 // screen size: (1024.0, 1366.0)
    }
    
    public enum DeviceType: String {
        case iPhone
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPhoneXMax
        case iPhoneUnknown
        case iPad
        case iPad10_5
        case iPad11
        case iPad12_9
        case iPadUnknown
        case unknown
        
        static func byScreenMaxWidth(_ screenMaxWidth: ScreenMaxWidth) -> DeviceType {
            switch screenMaxWidth {
            case .iPhone4: return .iPhone4
            case .iPhone5: return .iPhone5
            case .iPhone6: return .iPhone6
            case .iPhone6Plus: return .iPhone6Plus
            case .iPhoneX: return .iPhoneX
            case .iPhoneXMax: return .iPhoneXMax
            case .iPad: return .iPad
            case .iPad10_5: return .iPad10_5
            case .iPad11: return .iPad11
            case .iPad12_9: return .iPad12_9
            }
        }
    }
    
    class var maxWidth: Float {
        let w = Float(UIScreen.main.bounds.width)
        let h = Float(UIScreen.main.bounds.height)
        return fmax(w, h)
    }
    
    public class var isPhoneIdiom: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public class var isPadIdiom: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public class var isPhone4: Bool {
        return isPhoneIdiom && maxWidth == ScreenMaxWidth.iPhone4.rawValue
    }
    
    public class var isPhone5: Bool {
        return isPhoneIdiom && maxWidth == ScreenMaxWidth.iPhone5.rawValue
    }
    
    public class var isPhone6: Bool {
        return isPhoneIdiom && maxWidth == ScreenMaxWidth.iPhone6.rawValue
    }
    
    public class var isPhone6Plus: Bool {
        return isPhoneIdiom && maxWidth == ScreenMaxWidth.iPhone6Plus.rawValue
    }
    
    public class var isPhoneX: Bool {
        return isPhoneIdiom && maxWidth == ScreenMaxWidth.iPhoneX.rawValue
    }
    
    public class var isPhoneXMax: Bool {
        return isPhoneIdiom && maxWidth == ScreenMaxWidth.iPhoneXMax.rawValue
    }
    
    public class var isPad: Bool {
        return isPadIdiom && maxWidth == ScreenMaxWidth.iPad.rawValue
    }
    
    public class var isPad10_5: Bool {
        return isPadIdiom && maxWidth == ScreenMaxWidth.iPad10_5.rawValue
    }
    
    public class var isPad11: Bool {
        return isPadIdiom && maxWidth == ScreenMaxWidth.iPad11.rawValue
    }
    
    public class var isPad12_9: Bool {
        return isPadIdiom && maxWidth == ScreenMaxWidth.iPad12_9.rawValue
    }
}
