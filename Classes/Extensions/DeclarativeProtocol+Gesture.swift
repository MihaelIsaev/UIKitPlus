import UIKit

extension DeclarativeProtocol {
    @discardableResult
    public func gesture(_ recognizer: UIGestureRecognizer) -> Self {
        gestures(recognizer)
    }
    
    @discardableResult
    public func gestures(_ recognizers: UIGestureRecognizer...) -> Self {
        gestures(recognizers)
    }
    
    @discardableResult
    public func gestures(_ recognizers: [UIGestureRecognizer]) -> Self {
        recognizers.forEach { declarativeView.addGestureRecognizer($0) }
        return self
    }
    
    @discardableResult
    public func gestures(@GesturesBuilder block: GesturesBuilder.Block) -> Self {
        gestures(block().gestureRecognizers)
    }
    
    @discardableResult
    public func gestures(@GesturesBuilder block: (Self) -> GesturesBuilderItem) -> Self {
        gestures(block(self).gestureRecognizers)
    }
}
