import UIKit

open class HStackView: _StackView {
    public init (_ subviews: UIView...)  {
        super.init(frame: .zero)
        axis = .horizontal
        subviews.forEach { self.addArrangedSubview($0) }
    }
    
    public init (_ subviews: () -> [UIView])  {
        super.init(frame: .zero)
        axis = .horizontal
        subviews().forEach { self.addArrangedSubview($0) }
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
