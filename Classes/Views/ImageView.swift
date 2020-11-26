import UIKit

public typealias UImage = Image
open class Image: UIImageView, AnyDeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Image { self }
    public lazy var properties = Properties<Image>()
    lazy var _properties = PropertiesInternal()
    
    @UState public var height: CGFloat = 0
    @UState public var width: CGFloat = 0
    @UState public var top: CGFloat = 0
    @UState public var leading: CGFloat = 0
    @UState public var left: CGFloat = 0
    @UState public var trailing: CGFloat = 0
    @UState public var right: CGFloat = 0
    @UState public var bottom: CGFloat = 0
    @UState public var centerX: CGFloat = 0
    @UState public var centerY: CGFloat = 0
    
    var __height: UState<CGFloat> { _height }
    var __width: UState<CGFloat> { _width }
    var __top: UState<CGFloat> { _top }
    var __leading: UState<CGFloat> { _leading }
    var __left: UState<CGFloat> { _left }
    var __trailing: UState<CGFloat> { _trailing }
    var __right: UState<CGFloat> { _right }
    var __bottom: UState<CGFloat> { _bottom }
    var __centerX: UState<CGFloat> { _centerX }
    var __centerY: UState<CGFloat> { _centerY }
    
    var _imageLoader: ImageLoader = .defaultRelease
    
    public init (_ named: String) {
        super.init(frame: .zero)
        image = UIImage(named: named)
        _setup()
    }
    
    public init (_ image: UIImage?) {
        super.init(frame: .zero)
        self.image = image
        _setup()
    }
    
    public init (_ image: UState<UIImage?>) {
        super.init(frame: .zero)
        self.image = image.wrappedValue
        _setup()
        image.listen { [weak self] old, new in
            guard let self = self else { return }
            self.image = new
        }
    }
    
    public init <V>(_ expressable: ExpressableState<V, UIImage?>) {
        super.init(frame: .zero)
        self.image = expressable.value()
        _setup()
        expressable.state.listen { [weak self] old, new in
            guard let self = self else { return }
            self.image = expressable.value()
        }
    }
    
    public init (_ url: UState<URL>, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
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
    
    public init (_ url: UState<String>, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
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
    
    public init <V>(_ expressable: ExpressableState<V, String>, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
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
    
    public init (url: URL, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url, imageView: self, defaultImage: defaultImage)
    }
    
    public init (url: String, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
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
    
    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        buildView()
    }
    
    deinit {
        _imageLoader.cancel()
    }
    
    open func buildView() {}
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movedToSuperview()
    }
    
    @discardableResult
    public func mode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    @discardableResult
    public func clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value
        return self
    }
    
    @discardableResult
    public func load(url: URL, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) -> Self {
        image = defaultImage
        _imageLoader = loader
        _imageLoader.load(url, imageView: self, defaultImage: defaultImage)
        return self
    }
    
    @discardableResult
    public func load(url: String, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) -> Self {
        image = defaultImage
        _imageLoader = loader
        _imageLoader.load(url, imageView: self, defaultImage: defaultImage)
        return self
    }
}
