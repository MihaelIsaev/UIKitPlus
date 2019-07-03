//: A UIKit based Playground for presenting user interface
  
import UIKit
import UIKitPlus
import PlaygroundSupport

extension Image {
    static var horse: Image { return Image("wwdc-2019-horse.jpg") }
}

class MyViewController : UIViewController {
    override func loadView() {
        self.view = View.subviews {
            let avatar = Image.horse.mode(.scaleAspectFill)
                                                .border(1, .white)
                                                .circle()
                                                .topToSuperview(100)
                                                .centerXInSuperview()
                                                .size(100)
            let vStack = VStackView (
                WrapperView (
                    Label("Hello World!").color(.magenta).background(.black)
                ).background(.purple).padding(),
                Label("Hello World!").color(.magenta).background(.black).alignment(.center),
                Button("🚀 Tap me!").background(.darkGray)
                                               .backgroundHighlighted(.gray)
                                               .circle()
                                               .tapAction { button in
                                                button.title("🎉 Tapped!")
                                                UIView.animate(withDuration: 0.5) {
                                                    avatar.bottom = 100
                                                    avatar.width = avatar.width == 100 ? 300 : 100
                                                    avatar.height = avatar.height == 100 ? 300 : 100
                                                    avatar.layoutIfNeeded()
                                                }
                                                
                }
            ).top(to: avatar, .bottom, 16)
             .centerXInSuperview()
             .spacing(10)
             .background(.green)
            
            return [avatar, vStack]
        }.background(.red)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
