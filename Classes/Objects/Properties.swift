import UIKit

public class Properties<V> {
    @State var alpha: CGFloat = 1
    var alphaState: State<CGFloat> { _alpha }
    
    @State var opacity: Float = 1
    var opacityState: State<Float> { _opacity }
    
    @State var hidden: Bool = false
    var hiddenState: State<Bool> { _hidden }
    
    @State var userInteraction: Bool = false
    var userInteractionState: State<Bool> { _userInteraction }
    
    @State var tint: UIColor = .clear
    var tintState: State<UIColor> { _tint }
    
    @State var background: UIColor = .clear
    var backgroundState: State<UIColor> { _background }
    
    @State var color: UIColor = .clear
    var colorState: State<UIColor> { _color }
    
    @State var textColor: UIColor = .clear
    var textColorState: State<UIColor> { _textColor }
}
