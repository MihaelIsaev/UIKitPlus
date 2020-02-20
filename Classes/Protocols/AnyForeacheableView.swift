//
//  AnyForeacheableView.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 20.02.2020.
//

import UIKit

protocol AnyForeacheableView: DeclarativeProtocol, ListableForEach {}
extension AnyForeacheableView {
    func subscribeToChanges(_ handler: @escaping ([Int], [Int], [Int]) -> Void) {
        self.hidden.listen { old, new in
            guard old != new else { return }
            switch new {
            case true: handler([0], [], [])
            case false: handler([], [0], [])
            }
        }
    }
}

extension View: AnyForeacheableView {}
extension _StackView: AnyForeacheableView {}
extension Image: AnyForeacheableView {}
extension ActivityIndicator: AnyForeacheableView {}
extension Button: AnyForeacheableView {}
extension DatePicker: AnyForeacheableView {}
extension ScrollView: AnyForeacheableView {}
extension PickerView: AnyForeacheableView {}
extension Stepper: AnyForeacheableView {}
extension Text: AnyForeacheableView {}
extension SliderView: AnyForeacheableView {}
extension TextField: AnyForeacheableView {}
extension TextView: AnyForeacheableView {}
extension Toggle: AnyForeacheableView {}
