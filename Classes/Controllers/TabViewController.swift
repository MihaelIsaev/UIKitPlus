import UIKit

class TabViewController: ViewController {
    @discardableResult
    public func title(_ title: String) {
        navigationItem.title = title
        tabBarItem.title = title
    }
    
    @discardableResult
    public func title(_ header: String, _ item: String) {
        navigationItem.title = header
        tabBarItem.title = item
    }
    
    @discardableResult
    public func icon(_ image: UIImage?) {
        tabBarItem.image = image
    }
    
    @discardableResult
    public func icon(_ named: String) {
        tabBarItem.image = UIImage(named: named)
    }
    
    @discardableResult
    public func tint(_ color: UIColor) {
        tabBarController?.tabBar.tintColor = color
    }
    
    @discardableResult
    public func tint(_ numberColor: Int) {
        tabBarController?.tabBar.tintColor = numberColor.color
    }
}
