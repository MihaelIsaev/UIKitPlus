#if canImport(SwiftUI) && DEBUG
import SwiftUI

@_exported import protocol SwiftUI.PreviewProvider

@available(iOS 13.0, *)
public struct LiveView: UIViewRepresentable {
    let view: UIView
    
    public init (_ vc: UIViewController) {
        self.view = vc.view
    }
    
    public init (_ view: UIView) {
        self.view = view
    }
    
    public func makeUIView(context: Context) -> UIView { view }
    
    public func updateUIView(_ view: UIView, context: Context) {}
}

public enum PreviewColorScheme {
    case light, dark
    @available(iOS 13.0, *)
    fileprivate var val: SwiftUI.ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}

public struct UIKitPreviewDevice {
    let name: String
    
    public init (_ name: String) {
        self.name = name
    }
    
    ///     "None"
    public static var none: Self { .init("none") }
    ///     "Mac"
    public static var mac: Self { .init("Mac") }
    ///     "iPhone 7"
    public static var iPhone7: Self { .init("iPhone 7") }
    ///     "iPhone 7 Plus"
    public static var iPhone7Plus: Self { .init("iPhone 7 Plus") }
    ///     "iPhone 8"
    public static var iPhone8: Self { .init("iPhone 8") }
    ///     "iPhone 8 Plus"
    public static var iPhone8Plus: Self { .init("iPhone 8 Plus") }
    ///     "iPhone SE"
    public static var iPhoneSE: Self { .init("iPhone SE") }
    ///     "iPhone X"
    public static var iPhoneX: Self { .init("iPhone X") }
    ///     "iPhone Xs"
    public static var iPhoneXs: Self { .init("iPhone Xs") }
    ///     "iPhone Xs Max"
    public static var iPhoneXsMax: Self { .init("iPhone Xs Max") }
    ///     "iPhone Xʀ"
    public static var iPhoneXr: Self { .init("iPhone Xʀ") }
    ///     "iPad mini 4"
    public static var iPadMini4: Self { .init("iPad mini 4") }
    ///     "iPad Air 2"
    public static var iPadAir2: Self { .init("iPad Air 2") }
    ///     "iPad Pro (9.7-inch)"
    public static var iPadPro9_7: Self { .init("iPad Pro (9.7-inch)") }
    ///     "iPad Pro (12.9-inch)"
    public static var iPadPro12_9: Self { .init("iPad Pro (12.9-inch)") }
    ///     "iPad (5th generation)"
    public static var iPad_5gen: Self { .init("iPad (5th generation)") }
    ///     "iPad Pro (12.9-inch) (2nd generation)"
    public static var iPadPro12_9_2gen: Self { .init("iPad Pro (12.9-inch) (2nd generation)") }
    ///     "iPad Pro (10.5-inch)"
    public static var iPadPro10_5: Self { .init("iPad Pro (10.5-inch)") }
    ///     "iPad (6th generation)"
    public static var iPad_6gen: Self { .init("iPad (6th generation)") }
    ///     "iPad Pro (11-inch)"
    public static var iPadPro11: Self { .init("iPad Pro (11-inch)") }
    ///     "iPad Pro (12.9-inch) (3rd generation)"
    public static var iPadPro12_9_3gen: Self { .init("iPad Pro (12.9-inch) (3rd generation)") }
    ///     "iPad mini (5th generation)"
    public static var iPadMini_5gen: Self { .init("iPad mini (5th generation)") }
    ///     "iPad Air (3rd generation)"
    public static var iPadAir_3gen: Self { .init("iPad Air (3rd generation)") }
    ///     "Apple TV"
    public static var appleTV: Self { .init("Apple TV") }
    ///     "Apple TV 4K"
    public static var appleTV4K: Self { .init("Apple TV 4K") }
    ///     "Apple TV 4K (at 1080p)"
    public static var appleTV4Kat1080p: Self { .init("Apple TV 4K (at 1080p)") }
    ///     "Apple Watch Series 2 - 38mm"
    public static var AppleWatchSeries2_38mm: Self { .init("Apple Watch Series 2 - 38mm") }
    ///     "Apple Watch Series 2 - 42mm"
    public static var AppleWatchSeries2_42mm: Self { .init("Apple Watch Series 2 - 42mm") }
    ///     "Apple Watch Series 3 - 38mm"
    public static var AppleWatchSeries3_38mm: Self { .init("Apple Watch Series 3 - 38mm") }
    ///     "Apple Watch Series 3 - 42mm"
    public static var AppleWatchSeries3_42mm: Self { .init("Apple Watch Series 3 - 42mm") }
    ///     "Apple Watch Series 4 - 40mm"
    public static var AppleWatchSeries4_40mm: Self { .init("Apple Watch Series 4 - 40mm") }
    ///     "Apple Watch Series 4 - 44mm"
    public static var AppleWatchSeries4_44mm: Self { .init("Apple Watch Series 4 - 44mm") }
}

@available(iOS 13.0, *)
public class Preview {
    let view: UIView
    var colorScheme: PreviewColorScheme = .light
    var device: UIKitPreviewDevice = .iPhoneX
    var layout: PreviewLayout = .device
    var title: String = "Preview"
    var language: Language = Localization().detectCurrentLanguage()
    var semanticContentAttribute: UISemanticContentAttribute = .unspecified
    
    public init(@ViewBuilder block: ViewBuilder.SingleView) {
        view = View(block: block).edgesToSuperview()
    }
    
    @discardableResult
    public func colorScheme(_ v: PreviewColorScheme) -> Self {
        colorScheme = v
        return self
    }
    
    @discardableResult
    public func device(_ v: UIKitPreviewDevice) -> Self {
        device = v
        return self
    }
    
    @discardableResult
    public func layout(_ v: PreviewLayout) -> Self {
        layout = v
        return self
    }
    
    @discardableResult
    public func title(_ v: String) -> Self {
        title = v
        return self
    }
    
    @discardableResult
    public func language(_ v: Language) -> Self {
        language = v
        return self
    }
    
    @discardableResult
    public func rtl(_ v: Bool) -> Self {
        semanticContentAttribute = v ? .forceRightToLeft : .forceLeftToRight
        return self
    }
}

public protocol DeclarativePreview: SwiftUI.PreviewProvider {
    @available(iOSApplicationExtension 13.0, *)
    static var preview: Preview { get }
}

extension DeclarativePreview {
    @available(iOS 13.0, *)
    public static var previews: some SwiftUI.View {
        Localization.current = preview.language
        UIView.appearance().semanticContentAttribute = preview.semanticContentAttribute
        return LiveView(preview.view)
            .preferredColorScheme(preview.colorScheme.val)
            .previewLayout(preview.layout)
            .previewDisplayName(preview.title)
            .edgesIgnoringSafeArea(.all)
            .previewDevice(preview.device.name == "none" ? nil : PreviewDevice(rawValue: preview.device.name))
    }
}
#endif
