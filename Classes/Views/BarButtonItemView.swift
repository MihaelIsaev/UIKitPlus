import UIKit

open class BarButtonItem: UIBarButtonItem {
    public init(_ title: String?) {
        super.init()
        self.title = title
        setup()
    }
    
    // TODO: figure out how to implement `barButtonSystemItem`
//    public init(_ barButtonSystemItem: UIBarButtonItem.SystemItem) {
//        super.init()
//        self.image
//        setup()
//    }
    
    
    public init(image: UIImage?) {
        super.init()
        self.image = image
        setup()
    }
    
    public init(image imageName: String) {
        super.init()
        self.image = UIImage(named: imageName)
        setup()
    }
    
    public init(_ customView: UIView) {
        super.init()
        self.customView = customView
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        target = self
        action = #selector(tapEvenWithbuttont(_:))
    }
    
    // MARK: TouchUpInside
    
    public typealias TapAction = ()->Void
    public typealias TapActionWithButton = (BarButtonItem)->Void
    
    private var tapCallback: TapAction?
    private var tapWithButtonCallback: TapActionWithButton?
    
    @discardableResult
    public func tapAction(_ callback: @escaping TapAction) -> Self {
        tapCallback = callback
        return self
    }
    
    @discardableResult
    public func tapAction(_ callback: @escaping TapActionWithButton) -> Self {
        tapWithButtonCallback = callback
        return self
    }
    
    @objc private func tapEvenWithbuttont(_ button: BarButtonItem) {
        tapCallback?()
        tapWithButtonCallback?(button)
    }
    
    @discardableResult
    public func style(_ style: UIBarButtonItem.Style) -> Self {
        self.style = style
        return self
    }
    
    @discardableResult
    public func tint(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    public func tint(_ color: Int) -> Self {
        self.tintColor = color.color
        return self
    }
}
