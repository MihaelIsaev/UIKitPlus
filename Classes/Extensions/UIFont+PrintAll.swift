import UIKit

extension UIFont {
    public static func printAll() {
        let familyNames = UIFont.familyNames
        for family in familyNames {
            debugPrint("Family name " + family)
            let fontNames = UIFont.fontNames(forFamilyName: family)
            for font in fontNames {
                debugPrint("    Font name: " + font)
            }
        }
    }
}
