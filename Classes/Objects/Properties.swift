import UIKit

public class Properties<V> {
    @UState var alpha: CGFloat = 1
    var alphaState: UState<CGFloat> { _alpha }
    
    @UState var opacity: Float = 1
    var opacityState: UState<Float> { _opacity }
    
    @UState var hidden: Bool = false
    var hiddenState: UState<Bool> { _hidden }
    
    @UState var userInteraction: Bool = false
    var userInteractionState: UState<Bool> { _userInteraction }
    
    @UState var tint: UIColor = .clear
    var tintState: UState<UIColor> { _tint }
    
    @UState var background: UIColor = .clear
    var backgroundState: UState<UIColor> { _background }
    
    @UState var color: UIColor = .clear
    var colorState: UState<UIColor> { _color }
    
    @UState var textColor: UIColor = .clear
    var textColorState: UState<UIColor> { _textColor }
    
    var hovered: Bool = false
    
    public typealias FormatCharactersClosure = (_ textField: V, _ range: NSRange, _ replacement: String) -> Void
    public typealias ChangeCharactersClosure = (_ textField: V, _ range: NSRange, _ replacement: String) -> Bool
    public typealias BoolClosure = (V) -> Bool
    public typealias VoidClosure = (V) -> Void
    
    var _shouldBeginEditing: BoolClosure = { _ in return true }
    var _didBeginEditing: [VoidClosure] = []
    var _shouldEndEditing: BoolClosure = { _ in return true }
    var _didEndEditing: [VoidClosure] = []
    var _shouldFormatCharacters: FormatCharactersClosure?
    var _shouldChangeCharacters: ChangeCharactersClosure?
    var _shouldClear: BoolClosure = { _ in return true }
    var _shouldReturnVoid: () -> Void = {}
    var _shouldReturn: BoolClosure = { _ in return true }
    var _editingDidBegin: [VoidClosure] = []
    var _editingChanged: [VoidClosure] = []
    var _editingDidEnd: [VoidClosure] = []
}
