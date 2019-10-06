import UIKit

open class HUD: View {
    override public var declarativeView: HUD { return self }
    
    var imageHeight: CGFloat = 50
    lazy var imageView = Image(nil)
        .mode(.scaleAspectFit)
    lazy var symbolLabel = Label()
        .font(v: .boldSystemFont(ofSize: 48))
        .color(.white)
        .alignment(.center)
    lazy var activityIndicator = ActivityIndicator(style: .whiteLarge)
    lazy var titleLabel = Label()
        .font(v: .boldSystemFont(ofSize: 24))
        .color(.white)
        .alignment(.center)
    lazy var subTitleLabel = Label()
        .multiline()
        .font(v: .systemFont(ofSize: 16))
        .color(.white)
        .alignment(.center)
    lazy var contentView = View()
        .size(>=100)
        .corners(10)
        .background(.init(red: 0, green: 0, blue: 0, alpha: 0.7))
        .centerInSuperview()
        .topToSuperview(>=20)
        .leadingToSuperview(>=20 ! 999)
        .trailingToSuperview(<=(-20) ! 999)
        .bottomToSuperview(<=(-20))
    lazy var backgroundOverlay = View().background(.init(red: 0, green: 0, blue: 0, alpha: 0.2)).edgesToSuperview()
    
    open override func buildView() {
        super.buildView()
        hidden()
        edgesToSuperview()
        addSubview(backgroundOverlay, contentView)
    }
    
    // MARK: - Setup
    
    @discardableResult
    public func image(_ image: UIImage?) -> Self {
        imageView.image = image
        return self
    }
    
    @discardableResult
    public func symbol(_ value: String) -> Self {
        symbolLabel.text(value)
        return self
    }
    
    @discardableResult
    public func title(_ value: String) -> Self {
        titleLabel.text(value)
        return self
    }
    
    @discardableResult
    public func subTitle(_ value: String) -> Self {
        subTitleLabel.text(value)
        return self
    }
    
    // MARK: - Show/Hide
    
    @discardableResult
    public func show(_ animated: Bool = false) -> Self {
        superview?.bringSubviewToFront(self)
        activityIndicator.startAnimating()
        if !animated {
            hidden(false).alpha(1)
        } else {
            self.hidden(false).alpha(0)
            UIView.animate(withDuration: 0.3) {
                self.alpha(1)
            }
        }
        return self
    }
    
    @discardableResult
    public func hide(_ animated: Bool = false, _ completionHandler: (()->Void)? = nil) -> Self {
        if !animated {
            hidden()
            completionHandler?()
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha(0)
            }) { _ in
                self.activityIndicator.stopAnimating()
                self.hidden().alpha(1)
                completionHandler?()
            }
        }
        return self
    }
    
    @discardableResult
    public func hideAfter(_ timeInterval: TimeInterval, _ animated: Bool = false, _ completionHandler: (()->Void)? = nil) -> Self {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.hide(animated, completionHandler)
        }
        return self
    }
    
    // MARK: - Mode
    
    public enum Element {
        case image
        case symbol
        case activityIndicator
        case title
        case subTitle
        static var allElements: [Element] { return [.image, .symbol, .activityIndicator, .title, .subTitle] }
    }
    
    @discardableResult
    public func mode(_ elements: Element...) -> Self {
        // Elements to remove
        for element in Array(Set(Element.allElements).symmetricDifference(elements)) {
            switch element {
            case .image:
                guard let _ = imageView.superview else { continue }
                imageView.deactivateAndRemoveAllConstraints()
                imageView.removeFromSuperview()
            case .symbol:
                guard let _ = symbolLabel.superview else { continue }
                symbolLabel.deactivateAndRemoveAllConstraints()
                symbolLabel.removeFromSuperview()
            case .activityIndicator:
                guard let _ = activityIndicator.superview else { continue }
                activityIndicator.deactivateAndRemoveAllConstraints()
                activityIndicator.removeFromSuperview()
            case .title:
                guard let _ = titleLabel.superview else { continue }
                titleLabel.deactivateAndRemoveAllConstraints()
                titleLabel.removeFromSuperview()
            case .subTitle:
                guard let _ = subTitleLabel.superview else { continue }
                subTitleLabel.deactivateAndRemoveAllConstraints()
                subTitleLabel.removeFromSuperview()
            }
        }
        // Add elements into content view
        var elements = elements
        var topView: UIView?
        while elements.count > 0 {
            let element = elements.removeFirst()
            switch element {
            case .image:
                imageView.deactivateAndRemoveAllConstraints()
                imageView.removeFromSuperview()
                if let topView = topView {
                    imageView.top(to: .bottom, of: topView, 4)
                } else {
                    imageView.topToSuperview(20)
                }
                if elements.count == 0 {
                    imageView.bottomToSuperview(-20)
                }
                imageView.height(imageHeight).edgesToSuperview(leading: 20, trailing: -20)
                contentView.addSubview(imageView)
                topView = imageView
            case .symbol:
                symbolLabel.deactivateAndRemoveAllConstraints()
                symbolLabel.removeFromSuperview()
                if let topView = topView {
                    symbolLabel.top(to: .bottom, of: topView, 4)
                } else {
                    symbolLabel.topToSuperview(20)
                }
                if elements.count == 0 {
                    symbolLabel.bottomToSuperview(-20)
                }
                symbolLabel.edgesToSuperview(leading: 20, trailing: -20)
                contentView.addSubview(symbolLabel)
                topView = symbolLabel
            case .activityIndicator:
                activityIndicator.deactivateAndRemoveAllConstraints()
                activityIndicator.removeFromSuperview()
                if let topView = topView {
                    activityIndicator.top(to: .bottom, of: topView, 4)
                } else {
                    activityIndicator.topToSuperview(20)
                }
                if elements.count == 0 {
                    activityIndicator.bottomToSuperview(-20)
                }
                activityIndicator.centerXInSuperview()
                contentView.addSubview(activityIndicator)
                topView = activityIndicator
            case .title:
                titleLabel.deactivateAndRemoveAllConstraints()
                titleLabel.removeFromSuperview()
                if let topView = topView {
                    titleLabel.top(to: .bottom, of: topView, 4)
                } else {
                    titleLabel.topToSuperview(20)
                }
                if elements.count == 0 {
                    titleLabel.bottomToSuperview(-20)
                }
                titleLabel.edgesToSuperview(leading: 20, trailing: -20)
                contentView.addSubview(titleLabel)
                topView = titleLabel
            case .subTitle:
                subTitleLabel.deactivateAndRemoveAllConstraints()
                subTitleLabel.removeFromSuperview()
                if let topView = topView {
                    subTitleLabel.top(to: .bottom, of: topView, 4)
                } else {
                    subTitleLabel.topToSuperview(20)
                }
                if elements.count == 0 {
                    subTitleLabel.bottomToSuperview(-20)
                }
                subTitleLabel.edgesToSuperview(leading: 20, trailing: -20)
                contentView.addSubview(subTitleLabel)
                topView = subTitleLabel
            }
        }
        return self
    }
    
    // MARK: - Colors
    
    @discardableResult
    public func indicatorColor(_ color: UIColor) -> Self {
        activityIndicator.color = color
        return self
    }
    
    @discardableResult
    public func indicatorColor(_ number: Int) -> Self {
        activityIndicator.color = number.color
        return self
    }
    
    @discardableResult
    public func contentViewColor(_ color: UIColor) -> Self {
        contentView.background(color)
        return self
    }
    
    @discardableResult
    public func contentViewColor(_ number: Int) -> Self {
        contentView.background(number)
        return self
    }
    
    @discardableResult
    public func dimColor(_ color: UIColor) -> Self {
        backgroundOverlay.background(color)
        return self
    }
    
    @discardableResult
    public func dimColor(_ number: Int) -> Self {
        backgroundOverlay.background(number)
        return self
    }
}

