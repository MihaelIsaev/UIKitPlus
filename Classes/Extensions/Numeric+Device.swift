#if !os(macOS)
import Foundation
import UIKit

precedencegroup NumberByModelPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left
}

infix operator !! : NumberByModelPrecedence
public func !! <T>(lhs: T, rhs: iPhoneNumeric) -> T where T: BinaryInteger {
    lhs.dev(rhs)
}
public func !! <T>(lhs: T, rhs: iPhoneNumeric) -> T where T: BinaryFloatingPoint {
    lhs.dev(rhs)
}

public enum iPhoneNumeric {
    case iPhone4(Any)
    case iPhone5(Any)
    case iPhone6(Any)
    case iPhone6Plus(Any)
    case iPhone7(Any)
    case iPhone7Plus(Any)
    case iPhone8(Any)
    case iPhone8Plus(Any)
    case iPhoneXr(Any)
    case iPhoneX(Any)
    case iPhoneXMax(Any)
    case iPhoneXS(Any)
    case iPhoneXSMax(Any)
    case iPhoneMini(Any)
    case iPhonePro(Any)
    case iPhoneProMax(Any)
    case iPad(Any)
    case iPad10(Any)
    case iPad12(Any)
    var isActual: Bool {
        switch self {
        case .iPhone4: return UIDevice.isPhone4
        case .iPhone5: return UIDevice.isPhone5
        case .iPhone6: return UIDevice.isPhone6
        case .iPhone6Plus: return UIDevice.isPhone6Plus
        case .iPhone7: return UIDevice.isPhone6
        case .iPhone7Plus: return UIDevice.isPhone6Plus
        case .iPhone8: return UIDevice.isPhone6
        case .iPhone8Plus: return UIDevice.isPhone6Plus
        case .iPhoneXr: return UIDevice.isPhoneXr
        case .iPhoneX: return UIDevice.isPhoneX
        case .iPhoneXMax: return UIDevice.isPhoneXMax
        case .iPhoneXS: return UIDevice.isPhoneX
        case .iPhoneXSMax: return UIDevice.isPhoneXMax
        case .iPhoneMini: return UIDevice.isPhoneX
        case .iPhonePro: return UIDevice.isPhonePro
        case .iPhoneProMax: return UIDevice.isPhoneXMax
        case .iPad: return UIDevice.isPad
        case .iPad10: return UIDevice.isPad10
        case .iPad12: return UIDevice.isPad12
        }
    }
}

extension BinaryInteger {
    func dev(_ model: iPhoneNumeric) -> Self {
        switch model {
        case .iPhone4(let v):
            guard UIDevice.isPhone4 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone5(let v):
            guard UIDevice.isPhone5 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone6(let v):
            guard UIDevice.isPhone6 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone6Plus(let v):
            guard UIDevice.isPhone6Plus else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone7(let v):
            guard UIDevice.isPhone6 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone7Plus(let v):
            guard UIDevice.isPhone6Plus else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone8(let v):
            guard UIDevice.isPhone6 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone8Plus(let v):
            guard UIDevice.isPhone6Plus else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXr(let v):
            guard UIDevice.isPhoneXr else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneX(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXS(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXSMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneMini(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhonePro(let v):
            guard UIDevice.isPhonePro else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneProMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPad(let v):
            guard UIDevice.isPad else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPad10(let v):
            guard UIDevice.isPad10 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPad12(let v):
            guard UIDevice.isPad12 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        }
    }
}

extension BinaryFloatingPoint {
    func dev(_ model: iPhoneNumeric) -> Self {
        switch model {
        case .iPhone4(let v):
            guard UIDevice.isPhone4 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone5(let v):
            guard UIDevice.isPhone5 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone6(let v):
            guard UIDevice.isPhone6 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone6Plus(let v):
            guard UIDevice.isPhone6Plus else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone7(let v):
            guard UIDevice.isPhone6 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone7Plus(let v):
            guard UIDevice.isPhone6Plus else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone8(let v):
            guard UIDevice.isPhone6 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhone8Plus(let v):
            guard UIDevice.isPhone6Plus else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXr(let v):
            guard UIDevice.isPhoneXr else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneX(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXS(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXSMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneMini(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhonePro(let v):
            guard UIDevice.isPhonePro else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneProMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPad(let v):
            guard UIDevice.isPad else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPad10(let v):
            guard UIDevice.isPad10 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPad12(let v):
            guard UIDevice.isPad12 else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        }
    }
}
#endif
