import UIKit

public typealias UBarButtonItem = BarButtonItem
open class BarButtonItem: UIBarButtonItem {
    public init(_ title: String?) {
        super.init()
        self.title = title
        setup()
    }
    
    public init(_ localized: LocalizedString...) {
        super.init()
        self.title = String(localized)
        setup()
    }
    
    public init(_ localized: [LocalizedString]) {
        super.init()
        self.title = String(localized)
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
    
    public init(_ image: UState<UIImage>) {
        super.init()
        self.image = image.wrappedValue
        setup()
        image.listen { self.image = $0 }
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
    
    // MARK: tint
    
    @discardableResult
    public func tint(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    public func tint(_ color: Int) -> Self {
        tint(color.color)
    }
    
    @discardableResult
    public func tint(_ binding: UState<UIColor>) -> Self {
        binding.listen { self.tint($0) }
        return tint(binding.wrappedValue)
    }
    
    @discardableResult
    public func tint<V>(_ expressable: ExpressableState<V, UIColor>) -> Self {
        expressable.state.listen { _ in self.tint(expressable.value()) }
        return tint(expressable.value())
    }
    
    @discardableResult
    public func tint(_ binding: UState<Int>) -> Self {
        binding.listen { self.tint($0) }
        return tint(binding.wrappedValue)
    }
    
    @discardableResult
    public func tint<V>(_ expressable: ExpressableState<V, Int>) -> Self {
        expressable.state.listen { _ in self.tint(expressable.value()) }
        return tint(expressable.value())
    }
}
