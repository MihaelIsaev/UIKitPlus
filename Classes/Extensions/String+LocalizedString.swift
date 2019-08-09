import Foundation

extension String {
    public init (_ ls: LocalizedString...) {
        self.init(ls)
    }
    
    public init (_ ls: [LocalizedString]) {
        guard ls.count > 0 else {
            self.init("")
            print("⚠️ Localization: ❌ EMPTY STRING")
            return
        }
        var lsByPrefix: LocalizedString?
        for ls in ls {
            switch ls.type {
            case .short:
                if Localization.current.rawValue.starts(with: ls.value) {
                    self.init(ls.value)
                    return
                }
            case .long:
                if ls.language == Localization.current {
                    self.init(ls.value)
                    return
                } else if ls.prefix == Localization.current.prefix {
                    lsByPrefix = ls
                }
            }
        }
        if let ls = lsByPrefix {
            self.init(ls.value)
            return
        }
        if let ls = ls.first(where: {
            $0.value.contains(Localization.default.rawValue)
                || $0.prefix == Localization.default.prefix }) {
            self.init(ls.value)
            return
        }
        self.init("❔❔❔")
        print("⚠️ Localization: ❌ UNABLE TO DETECT LOCALE 🤬 set breakpoint here to find that string")
    }
}
