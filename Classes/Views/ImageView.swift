import UIKit

open class Image: UIImageView, DeclarativeProtocol, DeclarativeProtocolInternal {
    public var declarativeView: Image { return self }
    
    var _circleCorners: Bool = false
    var _customCorners: CustomCorners?
    lazy var _borders = Borders()
    
    var _preConstraints = DeclarativePreConstraints()
    var _constraintsMain: DeclarativeConstraintsCollection = [:]
    var _constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
    
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
    
    public init (_ url: State<URL>, _ defaultImage: UIImage? = nil) {
        super.init(frame: .zero)
        _setup()
        self.image = defaultImage
        self._imageLoader.load(url.wrappedValue, imageView: self)
        url.listen { [weak self] old, new in
            guard let self = self else { return }
            self._imageLoader.load(new, imageView: self)
        }
    }
    
    public init (_ url: State<String>, _ defaultImage: UIImage? = nil, _ loader: ImageLoader = .defaultRelease) {
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
    public func loader(_ loader: ImageLoader) -> Self {
        _imageLoader = loader
        return self
    }
}
