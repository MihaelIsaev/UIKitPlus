import UIKit

open class Image: UIImageView, DeclarativeProtocol, DeclarativeProtocolInternal {
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
    
    var __height: State<CGFloat> { $height }
    var __width: State<CGFloat> { $width }
    var __top: State<CGFloat> { $top }
    var __leading: State<CGFloat> { $leading }
    var __left: State<CGFloat> { $left }
    var __trailing: State<CGFloat> { $trailing }
    var __right: State<CGFloat> { $right }
    var __bottom: State<CGFloat> { $bottom }
    var __centerX: State<CGFloat> { $centerX }
    var __centerY: State<CGFloat> { $centerY }
    
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
    
    public init (_ image: State<UIImage?>) {
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
    
    public init (_ url: State<URL>, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url.wrappedValue, imageView: self)
        url.listen { [weak self] old, new in
            guard let self = self else { return }
            self._imageLoader.load(new, imageView: self)
        }
    }
    
    public init (_ url: State<String>, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url.wrappedValue, imageView: self)
        url.listen { [weak self] old, new in
            guard let self = self else { return }
            self._imageLoader.load(new, imageView: self)
        }
    }
    
    public init (url: URL, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url, imageView: self)
    }
    
    public init (url: String, defaultImage: UIImage? = nil, loader: ImageLoader = .defaultRelease) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader = loader
        self._imageLoader.load(url, imageView: self)
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
        self._imageLoader.downloadTask?.cancel()
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
}
