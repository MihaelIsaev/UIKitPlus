import UIKit

class NotImplementedViewController: ViewController {
    override var statusBarStyle: StatusBarStyle { .light }
    
    let name: String
    
    init (_ name: String) {
        self.name = name
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func buildUI() {
        super.buildUI()
        view.backgroundColor = .darkGray
        body {
            Text(attributed: AttrStr("`\(name)`").foreground(.red), AttrStr(" hasn't been implemented yet"))
                .color(.white)
                .alignment(.center)
                .centerYInSuperview()
                .edgesToSuperview(leading: 0, trailing: 0)
        }
    }
}
