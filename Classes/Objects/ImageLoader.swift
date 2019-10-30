import Foundation
import UIKit

fileprivate let loaderQueue = DispatchQueue(label: "com.uikitplus.imageloader")

fileprivate let cache = ImagesCache()

open class ImagesCache {
    var cache = NSCache<NSString, NSData>()
    
    func save(_ key: String, _ image: Data) {
        cache.setObject(NSData(data: image), forKey: NSString(string: key))
    }
    
    func get(_ key: String) -> Data? {
        cache.object(forKey: NSString(string: key)) as? Data
    }
}

open class ImageLoader {
    lazy var fm = FileManager()
    
    public var reloadingStyle: ImageReloadingStyle
    
    public init (_ reloadingStyle: ImageReloadingStyle = .release) {
        self.reloadingStyle = reloadingStyle
    }
    
    open func load(_ url: URL, imageView: UIImageView, defaultImage: UIImage? = nil) {
        load(url.absoluteString, imageView: imageView, defaultImage: defaultImage)
    }
    
    open func load(_ url: String, imageView: UIImageView, defaultImage: UIImage? = nil) {
        DispatchQueue.main.async { [weak self] in
//            debugPrint("image load 0")
            loaderQueue.async { [weak self] in
//                debugPrint("image load 1")
                /// Checks if URL is valid, otherwise trying to set default image
                guard let url = URL(string: url) else {
//                    debugPrint("image load 1.1")
                    if let defaultImage = defaultImage {
//                        debugPrint("image load 1.2")
                        DispatchQueue.main.async { [weak self] in
                            imageView.image = defaultImage
//                            debugPrint("image load 1.3")
                        }
                    }
                    return
                }
//                debugPrint("image load 2")
                /// Builds path to image in cache
                guard let localImagePath = self?.localImagePath(url).path else { return }
//                debugPrint("image load 3")
                /// Tries to get image data from cache
                var cachedImageData = cache.get(url.absoluteString)
                var localImageData: Data?
                if cachedImageData == nil {
                    localImageData = self?.fm.contents(atPath: localImagePath)
                }
                
//                debugPrint("image load 4")
                /// Release `imageView.image` before downloading the new one
                DispatchQueue.main.async { [weak self] in
                    self?.releaseBeforeDownloading(imageView, defaultImage)
                }
//                debugPrint("image load 5")
                /// Checking if image exists in cache
                if let cachedImageData = cachedImageData, let image = UIImage(data: cachedImageData)?.forceLoad() {
//                    debugPrint("image load 5.1.1")
                    /// Apply chached image to `imageView.image`
                    DispatchQueue.main.async { [weak self] in
                        self?.applyLocalImage(imageView, image)
//                        debugPrint("image load 5.1.2")
                    }
                } else if let localImageData = localImageData, let image = UIImage(data: localImageData)?.forceLoad() {
//                    debugPrint("image load 5.2.1")
                    cache.save(url.absoluteString, localImageData)
                    /// Apply chached image to `imageView.image`
                    DispatchQueue.main.async { [weak self] in
                        self?.applyLocalImage(imageView, image)
//                        debugPrint("image load 5.2.2")
                    }
                }
//                debugPrint("image load 6")
                /// Downloads image data from URL
                self?.downloadImage(url) { [weak self] imageData in
//                    debugPrint("image load 7")
                    if let cachedImageData = cachedImageData {
//                        debugPrint("image load 7.1")
                        if imageData.hashValue != cachedImageData.hashValue {
//                            debugPrint("image load 7.1.1")
                            if let image = UIImage(data: imageData)?.forceLoad() {
                                DispatchQueue.main.async { [weak self] in
                                    self?.setImage(imageView, image)
                                }
                            }
                            cache.save(url.absoluteString, imageData)
                            self?.fm.createFile(atPath: localImagePath, contents: imageData, attributes: nil)
                        } else {
//                            debugPrint("image load 7.1.2")
                            if let image = UIImage(data: cachedImageData)?.forceLoad() {
                                DispatchQueue.main.async { [weak self] in
                                    self?.setImage(imageView, image)
                                }
                            }
                        }
                    } else if let localImageData = localImageData {
//                        debugPrint("image load 7.2")
                        if imageData.hashValue != localImageData.hashValue {
//                            debugPrint("image load 7.2.1")
                            if let image = UIImage(data: imageData)?.forceLoad() {
                                DispatchQueue.main.async { [weak self] in
                                    self?.setImage(imageView, image)
                                }
                            }
                            cache.save(url.absoluteString, imageData)
                            self?.fm.createFile(atPath: localImagePath, contents: imageData, attributes: nil)
                        } else {
//                            debugPrint("image load 7.2.2")
                            if let image = UIImage(data: localImageData)?.forceLoad() {
                                DispatchQueue.main.async { [weak self] in
                                    self?.setImage(imageView, image)
                                }
                            }
                        }
                    } else if let image = UIImage(data: imageData)?.forceLoad() {
//                        debugPrint("image load 7.3")
                        DispatchQueue.main.async { [weak self] in
                            self?.setImage(imageView, image)
                        }
                        cache.save(url.absoluteString, imageData)
                        self?.fm.createFile(atPath: localImagePath, contents: imageData, attributes: nil)
                    }
                }
            }
        }
    }
    
    /// Builds path to image in cache
    open func localImagePath(_ imageURL: URL) -> URL {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString
        return URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent("\(imageURL.lastPathComponent)"))
    }
    
    /// Release `imageView.image` before downloading the new one
    open func releaseBeforeDownloading(_ imageView: UIImageView, _ defaultImage: UIImage? = nil) {
        if reloadingStyle == .release {
            imageView.image = defaultImage
        }
    }
    
    /// Apply chached image to `imageView.image`
    open func applyLocalImage(_ imageView: UIImageView, _ image: UIImage) {
        setImage(imageView, image)
    }
    
    /// Set image with or without animation
    open func setImage(_ imageView: UIImageView, _ image: UIImage) {
        if self.reloadingStyle == .fade {
            UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                imageView.image = image
            }, completion: nil)
        } else {
            imageView.image = image
        }
    }
    
    public var downloadTask: URLSessionDataTask?
    
    /// Downloads image data from URL
    /// Calls on background thread
    open func downloadImage(_ url: URL, callback: @escaping (Data) -> Void) {
        downloadTask?.cancel()
        downloadTask = nil
        downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            debugPrint("image load 6 response.code: \((response as? HTTPURLResponse)?.statusCode) error: \(error)")
            guard let data = data else { return }
            callback(data)
        }
        downloadTask?.resume()
    }
}

extension ImageLoader {
    public static var defaultRelease: ImageLoader { .init(.release) }
    public static var defaultImmediate: ImageLoader { .init(.immediate) }
    public static var defaultFade: ImageLoader { .init(.fade) }
}

extension UIImage {
    /// A trick to force draw image on background thread
    func forceLoad() -> UIImage {
        guard let imageRef = self.cgImage else {
            return self //failed
        }
        let width = imageRef.width
        let height = imageRef.height
        let colourSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        guard let imageContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colourSpace, bitmapInfo: bitmapInfo) else {
            return self //failed
        }
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        imageContext.draw(imageRef, in: rect)
        if let outputImage = imageContext.makeImage() {
            let cachedImage = UIImage(cgImage: outputImage, scale: scale, orientation: imageOrientation)
            return cachedImage
        }
        return self //failed
    }
}
