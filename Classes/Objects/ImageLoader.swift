import Foundation
import UIKit

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
        /// Checks if URL is valid, otherwise trying to set default image
        guard let url = URL(string: url) else {
            if let defaultImage = defaultImage {
                imageView.image = defaultImage
            }
            return
        }
        
        /// Builds path to image in cache
        let localImagePath = self.localImagePath(url).path
        
        /// Tries to get image data from cache
        let localImageData = fm.contents(atPath: localImagePath)
        
        /// Release `imageView.image` before downloading the new one
        releaseBeforeDownloading(imageView, defaultImage)
        
        /// Checking if image exists in cache
        if let localImageData = localImageData, let image = UIImage(data: localImageData) {
            /// Apply chached image to `imageView.image`
            applyLocalImage(imageView, image)
        }
        
        /// Downloads image data from URL
        downloadImage(url) { [weak self] imageData in
            if let localImageData = localImageData {
                if imageData.hashValue != localImageData.hashValue {
                    if let image = UIImage(data: imageData) {
                        self?.setImage(imageView, image)
                    }
                    self?.fm.createFile(atPath: localImagePath, contents: imageData, attributes: nil)
                } else {
                    if let image = UIImage(data: localImageData) {
                        self?.setImage(imageView, image)
                    }
                }
            } else if let image = UIImage(data: imageData) {
                self?.setImage(imageView, image)
                self?.fm.createFile(atPath: localImagePath, contents: imageData, attributes: nil)
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
    
    /// Downloads image data from URL
    open func downloadImage(_ url: URL, callback: @escaping (Data) -> Void) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    callback(imageData)
                }
            }
        }
    }
}

extension ImageLoader {
    public static var defaultRelease: ImageLoader { .init(.release) }
    public static var defaultImmediate: ImageLoader { .init(.immediate) }
    public static var defaultFade: ImageLoader { .init(.fade) }
}
