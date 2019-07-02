import UIKit

public struct CustomCorners {
    let radius: CGFloat
    let corners: [UIRectCorner]
    
    init (radius: CGFloat, corners: [UIRectCorner]) {
        self.radius = radius
        self.corners = corners
    }
}
