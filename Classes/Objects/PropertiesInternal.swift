import UIKit

public class PropertiesInternal {
    var circleCorners: Bool = false
    var customCorners: CustomCorners?
    lazy var borders = Borders()
    
    var preConstraints = DeclarativePreConstraints()
    var constraintsMain: DeclarativeConstraintsCollection = [:]
    var constraintsOuter: DeclarativeConstraintsKeyValueCollection = [:]
}
