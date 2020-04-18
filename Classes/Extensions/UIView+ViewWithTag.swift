//
//  UIView+ViewWithTag.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 18.04.2020.
//

import UIKit

extension UIView {
    public func viewWithTagInSuperview(_ tag: Int) -> UIView? {
        if let view = viewWithTag(tag) {
            return view
        } else if let view = superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        } else if let view = superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.viewWithTag(tag) {
            return view
        }
        return nil
    }
}
