import UIKit

class TabViewController: ViewController {
    @discardableResult
    public func title(_ title: String) -> TabViewController {
        navigationItem.title = title
        tabBarItem.title = title
        return self
    }
    
    @discardableResult
    public func title(_ header: String, _ item: String) -> TabViewController {
        navigationItem.title = header
        tabBarItem.title = item
        return self
    }
    
    @discardableResult
    public func icon(_ image: UIImage?) -> TabViewController {
        tabBarItem.image = image
        return self
    }
    
    @discardableResult
    public func icon(_ named: String) -> TabViewController {
        tabBarItem.image = UIImage(named: named)
        return self
    }
    
    @discardableResult
    public func tint(_ color: UIColor) -> TabViewController {
        tabBarController?.tabBar.tintColor = color
        return self
    }
    
    @discardableResult
    public func tint(_ numberColor: Int) -> TabViewController {
        tabBarController?.tabBar.tintColor = numberColor.color
        return self
    }
}
