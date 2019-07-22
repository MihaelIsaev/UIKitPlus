import Foundation

precedencegroup NumberByModelPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left
}

infix operator !! : NumberByModelPrecedence
public func !! <T>(lhs: T, rhs: iPhoneNumeric) -> T where T: BinaryInteger {
    return lhs.dev(rhs)
}
public func !! <T>(lhs: T, rhs: iPhoneNumeric) -> T where T: BinaryFloatingPoint {
    return lhs.dev(rhs)
}

public enum iPhoneNumeric {
    case iPhone4(Any)
    case iPhone5(Any)
    case iPhone6(Any)
    case iPhone6Plus(Any)
    case iPhoneX(Any)
    case iPhoneXMax(Any)
    var isActual: Bool {
        switch self {
        case .iPhone4: return UIDevice.isPhone4
        case .iPhone5: return UIDevice.isPhone5
        case .iPhone6: return UIDevice.isPhone6
        case .iPhone6Plus: return UIDevice.isPhone6Plus
        case .iPhoneX: return UIDevice.isPhoneX
        case .iPhoneXMax: return UIDevice.isPhoneXMax
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
        case .iPhoneX(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
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
        case .iPhoneX(let v):
            guard UIDevice.isPhoneX else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        case .iPhoneXMax(let v):
            guard UIDevice.isPhoneXMax else { return self }
            return Self(Double(String(describing: v)) ?? Double(self))
        }
    }
}
