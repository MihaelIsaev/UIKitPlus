public func +(lhs: AttrStr, rhs: AttrStr) -> AttrStr {
    let attrStr = AttrStr("")
    attrStr.attributedString.append(lhs.attributedString)
    attrStr.attributedString.append(rhs.attributedString)
    return attrStr
}
