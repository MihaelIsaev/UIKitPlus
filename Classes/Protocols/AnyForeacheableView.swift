//
//  AnyForeacheableView.swift
//  UIKit-Plus
//
//  Created by Mihael Isaev on 20.02.2020.
//

import UIKit
public protocol AnyForeacheableView: DeclarativeProtocol, Listable, ListableBuilderItem {
    var isVisibleInList: Bool { get set }
}
protocol __AnyForeacheableView: ListableForEach {
    var isVisibleInList: Bool { get set }
}
protocol _AnyForeacheableView: __AnyForeacheableView, AnyForeacheableView {}
extension AnyForeacheableView  {
    public var count: Int { self.isVisibleInList ? 1 : 0 }
    public func item(at index: Int) -> [UIView] { [ View(inline: self.declarativeView) ] }
}
extension AnyForeacheableView {
    public var listableBuilderItems: [Listable] { [self] }
}
extension _AnyForeacheableView {
    func subscribeToChanges(_ begin: @escaping () -> Void, _ handler: @escaping ([Int], [Int], [Int]) -> Void, _ end: @escaping () -> Void) {
        self.hidden.beginTrigger(begin)
        self.hidden.listen { old, new in
            guard old != new else { return }
            switch new {
            case true:
                guard self.isVisibleInList else { return }
                self.isVisibleInList = false
                handler([0], [], [])
            case false:
                guard !self.isVisibleInList else { return }
                self.isVisibleInList = true
                handler([], [0], [])
            }
        }
        self.hidden.endTrigger(end)
    }
}

extension View: _AnyForeacheableView {}
extension _StackView: _AnyForeacheableView {}
extension Image: _AnyForeacheableView {}
extension ActivityIndicator: _AnyForeacheableView {}
extension Button: _AnyForeacheableView {}
extension DatePicker: _AnyForeacheableView {}
extension ScrollView: _AnyForeacheableView {}
extension PickerView: _AnyForeacheableView {}
extension Stepper: _AnyForeacheableView {}
extension Text: _AnyForeacheableView {}
extension SliderView: _AnyForeacheableView {}
extension TextField: _AnyForeacheableView {}
extension TextView: _AnyForeacheableView {}
extension Toggle: _AnyForeacheableView {}
