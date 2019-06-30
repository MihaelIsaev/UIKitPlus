//
//  TableView.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 30/06/2019.
//

import UIKit

open class TableView: UITableView, DeclarativeView {
    public var declarativeView: TableView { return self }
    
    public var _circleCorners: Bool = false
    public var _customCorners: CustomCorners?
    public lazy var _borders = Borders()
    
    public init (_ style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
}
