#if os(macOS)
import AppKit

open class UImage: NSImageView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Image { self }
    public lazy var properties = Properties<Image>()
    lazy var _properties = PropertiesInternal()
    
    @State public var height: CGFloat = 0
    @State public var width: CGFloat = 0
    @State public var top: CGFloat = 0
    @State public var leading: CGFloat = 0
    @State public var left: CGFloat = 0
    @State public var trailing: CGFloat = 0
    @State public var right: CGFloat = 0
    @State public var bottom: CGFloat = 0
    @State public var centerX: CGFloat = 0
    @State public var centerY: CGFloat = 0
    
    var __height: State<CGFloat> { _height }
    var __width: State<CGFloat> { _width }
    var __top: State<CGFloat> { _top }
    var __leading: State<CGFloat> { _leading }
    var __left: State<CGFloat> { _left }
    var __trailing: State<CGFloat> { _trailing }
    var __right: State<CGFloat> { _right }
    var __bottom: State<CGFloat> { _bottom }
    var __centerX: State<CGFloat> { _centerX }
    var __centerY: State<CGFloat> { _centerY }
    
    var _imageLoader: ImageLoader = .defaultRelease
    
    var contentMode: CALayerContentsGravity = .resize
    
    open override var image: NSImage? {
        set {
            let l = CALayer()
            if let v = self.layer?.cornerRadius {
                l.cornerRadius = v
            }
            if let v = self.layer?.opacity {
                l.opacity = v
            }
            if let v = self.layer?.masksToBounds {
                l.masksToBounds = v
            }
            l.borderColor = self.layer?.borderColor
            if let v = self.layer?.borderWidth {
                l.borderWidth = v
            }
            l.contentsGravity = contentMode
            l.contents = newValue
            self.layer = l
            self.wantsLayer = true
            super.image = newValue
        }
        get { super.image }
    }
    
    public init (_ named: String) {
        super.init(frame: .zero)
        image = NSImage(named: named)
        _setup()
    }
    
    public init (_ image: NSImage?) {
        super.init(frame: .zero)
        self.image = image
        _setup()
    }
    
    public init (_ image: State<NSImage?>) {
        super.init(frame: .zero)
        self.image = image.wrappedValue
        _setup()
        image.listen { [weak self] old, new in
            guard let self = self else { return }
            self.image = new
        }
    }
    
    public init <V>(_ expressable: ExpressableState<V, NSImage?>) {
        super.init(frame: .zero)
        self.image = expressable.value()
        _setup()
        expressable.state.listen { [weak self] old, new in
            guard let self = self else { return }
            self.image = expressable.value()
        }
    }
    
    public init (_ url: State<URL>, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url.wrappedValue, imageView: self, defaultImage: defaultImage)
        url.listen { [weak self] old, new in
            guard let self = self else { return }
            self._imageLoader.load(new, imageView: self, defaultImage: defaultImage)
        }
    }
    
    public init (_ url: State<String>, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url.wrappedValue, imageView: self, defaultImage: defaultImage)
        url.listen { [weak self] old, new in
            guard let self = self else { return }
            self._imageLoader.load(new, imageView: self, defaultImage: defaultImage)
        }
    }
    
    public init <V>(_ expressable: ExpressableState<V, String>, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(expressable.value(), imageView: self, defaultImage: defaultImage)
        expressable.state.listen { [weak self] old, new in
            guard let self = self else { return }
            self._imageLoader.load(expressable.value(), imageView: self, defaultImage: defaultImage)
        }
    }
    
    public init (url: URL, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url, imageView: self, defaultImage: defaultImage)
    }
    
    public init (url: String, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url, imageView: self, defaultImage: defaultImage)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var clipsToBounds = false
    open override var wantsDefaultClipping: Bool { !clipsToBounds }
    
    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        buildView()
    }
    
    deinit {
        _imageLoader.cancel()
    }
    
    open func buildView() {}
    
    open override func layout() {
        super.layout()
        onLayoutSubviews()
    }
    
    open override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        movedToSuperview()
    }
    
    @discardableResult
    public func mode(_ mode: CALayerContentsGravity) -> Self {
        contentMode = mode
        image = super.image
        return self
    }
    
    @discardableResult
    public func clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value
        return self
    }
    
    @discardableResult
    public func load(url: URL, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) -> Self {
        image = defaultImage
        _imageLoader = loader
        _imageLoader.load(url, imageView: self, defaultImage: defaultImage)
        return self
    }
    
    @discardableResult
    public func load(url: String, defaultImage: NSImage? = nil, loader: ImageLoader = .defaultRelease) -> Self {
        image = defaultImage
        _imageLoader = loader
        _imageLoader.load(url, imageView: self, defaultImage: defaultImage)
        return self
    }
}

extension UImage: _Tintable {
    var _tintState: State<UColor> {
        get { properties.tintState }
        set {}
    }
    
    func _setTint(_ v: NSColor?) {
        guard let v = v else { return }
        image = tintedImage(with: v)
    }
    
    func tintedImage(with tintColor: NSColor) -> NSImage? {
        guard let image = self.image else { return self.image }
        guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return self.image }
        
        return NSImage(size: image.size, flipped: false) { bounds in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }
            tintColor.set()
            context.clip(to: bounds, mask: cgImage)
            context.fill(bounds)
            return true
        }
    }
}
#endif
