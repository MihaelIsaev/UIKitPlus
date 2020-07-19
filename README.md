<p align="center">
    <a href="LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/swift-5.2-brightgreen.svg" alt="Swift 5.2">
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/iOS-9+-brightgreen.svg" alt="Swift 5.2">
    </a>
    <img src="https://img.shields.io/badge/iPadOS+Catalyst-✓-brightgreen.svg" alt="iPadOS and Catalyst support">
    <a href="https://cocoapods.org/pods/UIKit-Plus">
        <img src="https://img.shields.io/cocoapods/v/UIKit-Plus.svg" alt="Cocoapod">
    </a>
    <a href="https://discord.gg/q5wCPYv">
        <img src="https://img.shields.io/discord/612561840765141005" alt="Swift.Stream">
    </a>
</p>
<p align="center">🚀❤️ YOU WILL LOVE <b>UIKIT</b> MORE THAN EVER ❤️🚀</p>
<br/>
<p align="center"><b>Nothing is impossible!</b></p>
<p align="center">Build awesome responsive UIs even simpler than with SwiftUI <b>cause you already know everything</b>.</p>
<br/>
<p align="center">With. Live. Preview. iOS9+.</p>
<br/>
<p align="center"><a href="https://github.com/MihaelIsaev/UIKitPlusExample" style="color:green;">A LOT OF EXAMPLES</a></p>
<p align="center"><a href="https://discord.gg/q5wCPYv">SWIFT.STREAM COMMUNITY IN DISCORD</a></p>

## Requirements

Xcode 11.4+

Swift 5.2+

Good mood

## Installation

#### With [CocoaPods](https://cocoapods.org)

Add the following line to your Podfile:
```ruby
pod 'UIKit-Plus', '~> 1.28.0'
```

#### With [Swift Package Manager](https://swift.org/package-manager/)

In Xcode 11.4+ go to `File -> Swift Packages -> Add Package Dependency` and enter there URL of this repo
```
https://github.com/MihaelIsaev/UIKitPlus
```

#### IMPORTANT!

To support iOS lower than 13 you have to set `-weak_framework SwiftUI` in `Other Linker Flags` in `Build Settings`.

Without that your app gonna crash on iOS lower than 13 because it will try to load SwiftUI without luck.

<img width="816" alt="Screenshot 2020-03-29 at 03 35 10" src="https://user-images.githubusercontent.com/1272610/77836323-bbd71e00-716e-11ea-88f8-3a6b135b99ec.png">

## Project Template! 🍾

To simplify life with UIKitPlus you can download our template!

For that run the following commands in console

```bash
git clone https://github.com/MihaelIsaev/UIKitPlus.git
cp -R UIKitPlus/Templates ~/Library/Developer/Xcode/
rm -rf UIKitPlus
```

After that you will be able to go to `File -> New -> Project` and choose `UIKitPlus` app! 🚀

![UIKitPlus App Template Screenshot](https://user-images.githubusercontent.com/1272610/78511655-87d3ac80-77af-11ea-96f7-dc0b75287207.jpg)

> 💡After project creation you have to install UIKitPlus manually either with Swift Package Manager or with CocoaPods

### File Template

Together with project template you will get the file template 👍

## Features

### 1. Delayed constraints

Declare all the constraints in advance before adding view to superview. Even by tags.
```swift
Button("Click me").width(300).centerInSuperview()
```

### 2. Declarativity

Build everything declarative way. Any view. Any control. Even layers, gestures, colors, fonts, etc.
```swift
Text("Hello world").color(.red).alignment(.center).font(.sfProMedium, 15)
```

### 3. Reactivity

Use `@State` for any property, react on any thing, map states to different types, etc.
```swift
@State var text = "Hello world"
Text($text)

@State var number = 5
Text($number.map { "\($0)" })

@State var bool = false
Text($bool.map { $0 ? "enabled" : "disabled" })
```

### 4. Purity

Everything is pretty clear. Clean short code without magic.

### 5. SwiftUI-like but still beloved UIKit

Declare subviews like in SwiftUI

```swift
body {
    View1()
    View2()
    View3()
    // btw it is NOT limited to 10
}
```

### 6. Reusable and extendable

Declare views or its styles in extensions. Subclass views. Use all the power of OOP.

### 7. All modern features

Diffable data-source (yes yes for iOS9+). Dynamic colors for light/dark mode. Stateable animations. Reactivity.

### 8. Everything and even more

Built-in `ImageLoader`, no need in huge 3rd party libs. Just set URL to `Image`. Fully customizable and overridable.
```swift
Image(url: "")
Image(url: "", defaultImage: UIImage(named: "emptyImage")) // set default image to show it while loading
Image(url: "", loader: .defaultRelease) // release image before start loading
Image(url: "", loader: .defaultImmediate) // immediate replace image after loading
Image(url: "", loader: .defaultFade) // replace image with fade effect after loading
Image(url: "", loader: ImageLoader()) // subclass from `ImageLoader` and set you custom loader here
```

Easy device model and type detection and ability to set values based on that.
```swift
Button("Click me").width(400 !! iPhone6(300) !! .iPhone5(200))
```

Localizable strings
```swift
Localization.default = .en // set any localization as default to use it with not covered languages
Localization.current = .en // override current locale
String(.en("Hello"), .fr("Bonjour"), .ru("Привет"))
```

Custom trait collections.

### 9. Live Preview

Live preview provided by SwiftUI (available only since macOS Catalina).

> The only problem we have is that since names of views are the same in `UIKitPlus` and `SwiftUI` we should use aliases like `UButton` for `Button` or `UView` for `View`, so everything with `U` prefix. It is only necessary if you want to use live previews, otherwise there is no need to import `SwiftUI`, so no name conflicts.

#### Preview single item

> 💡 You can create as many preview structs as you need

`ViewController` example

```swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct MyViewController_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            MainViewController()
        }
        .colorScheme(.dark)
        .device(.iPhoneX)
        .language(.fr)
        .rtl(true)
    }
}
#endif
```

`View` example

```swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct MyButton_Preview: PreviewProvider, DeclarativePreview {
    static var preview: Preview {
        Preview {
            UButton(String(.en("Hello"), .fr("Bonjour"), .ru("Привет")))
                .circle()
                .background(.blackHole / .white)
                .color(.white / .black)
                .height(54)
                .edgesToSuperview(h: 8)
                .centerYInSuperview()
        }
        .colorScheme(.dark)
        .layout(.fixed(width: 300, height: 64))
        .language(.fr)
        .rtl(true)
    }
}
#endif
```

#### Preview group 🔥

It is just convenient way to create multiple previews inside one struct

Limitations:
- only 10 previews inside group
- `rtl` and `language` properties can be set only to group, not to previews directly

```swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct MyPreviewGroup_Preview: PreviewProvider, DeclarativePreviewGroup {
    static var previewGroup: PreviewGroup {
        PreviewGroup { // 1 to 10 previews inside
            Preview {
                MainViewController()
            }
            .colorScheme(.dark)
            .device(.iPhoneX)
            Preview {
                MainViewController()
            }
            .colorScheme(.light)
            .device(.iPhoneX)
            Preview {
                // in this group title will be shown in `fr` language
                UButton(String(.en("Hello"), .fr("Bonjour"), .ru("Привет")))
                    .circle()
                    .background(.blackHole / .white)
                    .color(.white / .black)
                    .height(54)
                    .edgesToSuperview(h: 8)
                    .centerYInSuperview()
            }
            .colorScheme(.dark)
            .layout(.fixed(width: 300, height: 64))
        }
        .language(.fr) // limited to group
        .rtl(true) // limited to group
    }
}
#endif
```

## Usage

```swift
import UIKitPlus
```

Even no need to import `UIKit` at all!

<details>
<summary>Constraints</summary>

#### Solo

##### aspectRatio

```swift
/// 1:1
View().aspectRatio()

/// 1:1 low priority
View().aspectRatio(priority: .defaultLow)

/// 4:3
View().aspectRatio(4 / 3)

/// 4:3 low priority
View().aspectRatio(priority: .defaultLow)
```
##### width

```swift
/// 100pt
View().width(100)

/// Stateable width
@State var width: CGFloat = 100

View().width($width)

/// Stateable but based on different type
@State var expanded = false

View().width($expanded.map { $0 ? 200 : 100 })

/// Different value for different devices
/// 80pt for iPhone5, 120pt for any iPad, 100pt for any other devices
View().width(100 !! .iPhone5(80) !! .iPad(150))
```

##### height

```swift
/// 100pt
View().height(100)

/// Stateable width
@State var height: CGFloat = 100

View().height($width)

/// Stateable but based on different type
@State var expanded = false

View().height($expanded.map { $0 ? 200 : 100 })

/// Different value for different devices
/// 80pt for iPhone5, 120pt for any iPad, 100pt for any other devices
View().height(100 !! .iPhone5(80) !! .iPad(150))
```

##### size

```swift
/// width 100pt, height 100pt
View().size(100)

/// width 100pt, height 200pt
View().size(100, 200)

/// Stateable
@State var width: CGFloat = 100
@State var height: CGFloat = 100

View().size($width, 200)
View().size(100, $height)
View().size($width, $height)

/// for both
@State var size: CGFloat = 100
View().size($size)

/// Stateable but based on different type
@State var expanded = false

View().size($expanded.map { $0 ? 200 : 100 })
View().size(100, $expanded.map { $0 ? 200 : 100 })
View().size(100 !! .iPad(200), $expanded.map { $0 ? 200 !! .iPad(300) : 100 !! .iPad(200) })
View().size($width, $expanded.map { $0 ? 200 : 100 })
View().size($expanded.map { $0 ? 200 : 100 }, 100)
View().size($expanded.map { $0 ? 200 : 100 }, $height)
```

Read and write view's solo constraints directly. And even animate them.

```swift
let v = View()
v.width = 100
v.height = 100
UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
    v.width = 200
    v.height = 300
}.startAnimation()
```

#### Super

##### edges

```swift
/// all edges to superview 0pt
View().edgesToSuperview()

/// all edges to superview 16pt
View().edgesToSuperview(16)

/// horizontal edges: 16pt, vertical edges: 24pt
View().edgesToSuperview(16, 24)

/// horizontal edges: 16pt
View().edgesToSuperview(h: 16)

/// vertical edges: 24pt
View().edgesToSuperview(v: 24)

/// each edge to different value to superview
View().edgesToSuperview(top: 24, leading: 16, trailing: -16, bottom: -8)
```

##### top

```swift
/// 16pt to top of superview
View().topToSuperview(16)

/// 16pt to safeArea top of superview
View().topToSuperview(16, safeArea: true)

/// Stateable
@State var top: CGFloat = 16

View().topToSuperview($top)

/// Stateable but based on different type
@State var expanded = false

View().topToSuperview($expanded.map { $0 ? 0 : 16 })
```

##### leading

```swift
/// 16pt to leading of superview
View().leadingToSuperview(16)

/// all the same as with topToSuperview
```

##### trailing

```swift
/// -16pt to trailing of superview
View().trailingToSuperview(-16)

/// all the same as with topToSuperview
```

##### bottom

```swift
/// -16pt to bottom of superview
View().leadingToSuperview(-16)

/// all the same as with topToSuperview
```

##### centerX

```swift
/// right in center of superview horizontally
View().centerXInSuperview()

/// 16pt from horizontal center of superview
View().centerXToSuperview(16)

/// all the same as with topToSuperview
```

##### centerY

```swift
/// right in center of superview vertically
View().centerYInSuperview()

/// 16pt from vertical center of superview
View().centerYToSuperview(16)

/// all the same as with topToSuperview
```

##### center

```swift
/// right in center of superview both horizontally and vertically
View().centerInSuperview()

/// 16pt from horizontal center of superview, 8pt from vertical center of superview
View().centerInSuperview(x: 16, y: 8)

/// all the same as with topToSuperview
```

##### width

```swift
/// equal width with superview
View().widthToSuperview()

/// equal width with superview with low priority
View().widthToSuperview(priority: .defaultLow)

/// half width of superview
View().widthToSuperview(multipliedBy: 0.5)

/// half width of superview with low priority
View().widthToSuperview(multipliedBy: 0.5, priority: .defaultLow)

/// all the same as with topToSuperview
```

##### height

```swift
/// equal height with superview
View().heightToSuperview()

/// all the same as with widthToSuperview
```

Read and write view's super constraints directly. And even animate them.

```swift
let v = View()
v.top = 24
v.leading = 16
v.trailing = 16
v.bottom = -24
UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
    v.top = 0
    v.leading = 8
    v.trailing = 8
    v.bottom = 0
}.startAnimation()
```

#### Relative

##### top

```swift
View().top(to: otherView)
View().top(to: otherView, 16)
View().top(to: otherView, $topStateValue)
View().top(to: .top, of: otherView)
View().top(to: .top, of: otherView, $topStateValue)
```

##### leading
```swift
View().leading(to: otherView)

/// all the same as for top(to:)
```

##### trailing
```swift
View().trailing(to: otherView)

/// all the same as for top(to:)
```

##### bottom
```swift
View().bottom(to: otherView)

/// all the same as for top(to:)
```

##### left
```swift
View().left(to: otherView)

/// all the same as for top(to:)
```

##### right
```swift
View().right(to: otherView)

/// all the same as for top(to:)
```

##### centerX
```swift
View().centerX(to: otherView)

/// all the same as for top(to:)
```

##### centerY
```swift
View().centerY(to: otherView)

/// all the same as for top(to:)
```

##### center
```swift
View().center(to: otherView)

/// all the same as for top(to:)
```

##### width
```swift
View().width(to: otherView)

/// all the same as for top(to:)
```

##### height
```swift
View().height(to: otherView)

/// all the same as for top(to:)
```

##### equal
```swift
/// just a convenient method to width&height
View().equalSize(to: otherView)

/// all the same as for top(to:)
```

> 💡 TIP: Feel free to use `State`, `ExpressableState`, and values based on device type everywhere

#### Relative constraints by tags 🔥

<p align="center">
<img width="375" alt="Screenshot 2020-04-18 at 05 47 57" src="https://user-images.githubusercontent.com/1272610/79625178-2bba4200-8138-11ea-959b-f7487a45cee5.png">
</p>

Really often we have to create some views with constraints related to each other 😃

The classic way is to create a variable with view somewhere outside, like this

```swift
let someView = UView()
```

then we used it with other views to make relative constraints

```swift
UView {
    someView.size(200).background(.red).centerInSuperview()
    UView().size(100).background(.cyan).centerXInSuperview().top(to: someView)
    UView().size(100).background(.purple).centerXInSuperview().bottom(to: someView)
    UView().size(100).background(.yellow).centerYInSuperview().right(to: someView)
    UView().size(100).background(.green).centerYInSuperview().left(to: someView)
}
```

But if it's not necessary to declare view outside the you can use tag! And easily rely to it from other views!

```swift
UView {
    UView().size(200).background(.red).centerInSuperview().tag(7)
    UView().size(100).background(.cyan).centerXInSuperview().top(to: 7)
    UView().size(100).background(.purple).centerXInSuperview().bottom(to: 7)
    UView().size(100).background(.yellow).centerYInSuperview().right(to: 7)
    UView().size(100).background(.green).centerYInSuperview().left(to: 7)
}
```

Even order doesn't matter 🤗

```swift
UView {
    UView().size(100).background(.cyan).centerXInSuperview().top(to: 7)
    UView().size(100).background(.purple).centerXInSuperview().bottom(to: 7)
    UView().size(100).background(.yellow).centerYInSuperview().right(to: 7)
    UView().size(100).background(.green).centerYInSuperview().left(to: 7)
    UView().size(200).background(.red).centerInSuperview().tag(7)
}
```

You even can add view later and all related views will immediately stick to it once it's added 🚀

```swift
let v = UView {
    UView().size(100).background(.cyan).centerXInSuperview().top(to: 7)
    UView().size(100).background(.purple).centerXInSuperview().bottom(to: 7)
    UView().size(100).background(.yellow).centerYInSuperview().right(to: 7)
    UView().size(100).background(.green).centerYInSuperview().left(to: 7)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    UIView.animate(withDuration: 1) {
        v.body {
            UView().size(200).background(.red).centerInSuperview().tag(7)
        }
    }
}
```

#### Extra

Any constraint value may be set as `CGFloat` or with `Relation` and even `Multiplier`
```swift
// just equal to 10
View().leading(to: .trailing, of: anotherView, 10)

// greaterThanOrEqual to 10
View().leading(to: .trailing, of: anotherView, >=10)

// lessThanOrEqual to 10
View().leading(to: .trailing, of: anotherView, <=10)

// equal to 10 with 1.5 multiplier
View().leading(to: .trailing, of: anotherView, 10 ~ 1.5)

// equal to 10 with 1.5 multiplier and 999 priority
View().leading(to: .trailing, of: anotherView, 10 ~ 1.5 ! 999)

// equal to 10 with 1.5 multiplier and `.defaultLow` priority
View().leading(to: .trailing, of: anotherView, 10 ~ 1.5 ! .defaultLow)

// equal to 10 with 999 priority
View().leading(to: .trailing, of: anotherView, 10 ! 999)
```

#### More about constraints direct access
Ok, let's imagine that you have a view which is sticked to its superview
```swift
let view = View().edgesToSuperview()
```
now your view have top, leading, trailing and bottom constraints to its superview and e.g. you want to change `top` constraint so you could do it like this
```swift
view.top = 16
```
or
```swift
view.declarativeConstraints.top?.constant = 16
```
the same way works with all view's constraints, so you can change them or even delete them just by setting them `nil`.

Another situation if you have a view which have a constrain to another relative view
```swift
let centerView = View().background(.black).size(100).centerInSuperview()
let secondView = View().background(.green).size(100).centerXInSuperview().top(to: .bottom, of: centerView, 16)
```
and for example you want to reach bottom constraint of `centerView` related to `secondView`, do it like this
```swift
// short way
centerView.outer[.bottom, secondView] = 32 // changes their vertical spacing from 16 to 32
// long way
centerView.declarativeConstraints.outer[.bottom, secondView]?.constant = 32 // changes their vertical spacing from 16 to 32
```
</details>

<details>
<summary>Root View Controller 🍀</summary>

[Detailed instruction](Docs/RootViewController.md)
</details>

<details>
<summary>View</summary>

> alias is `UView`

View may be created with empty initializer
```swift
View()
```
or you can put subviews into it right while initialization
```swift
View {
    View()
    View()
}
```
or you can wrap some view using `inline` keyword so that inner view will stick all edges to superview
```swift
View(inline: MKMapView())
```
also you can add subviews to that superview by calling `.body { ... }` method. even multiple times.
```swift
View().body {
    View()
    View()
}.body {
    View()
}.body {
    View()
    View()
    View()
}
```
</details>

<details>
<summary>VerificationCodeView</summary>

`// implemented. to be described more`

This is really bonus view! :D Almost every app now uses verification codes for login and now you can easily implement that code view with UIKitPlus! :)
```swift
VerificationCodeField().digitWidth(64)
                       .digitsMargin(25)
                       .digitBorder(.bottom, 1, 0xC6CBD3)
                       .digitColor(0x171A1D)
                       .font(.sfProRegular, 32)
                       .entered(verify)

func verify(_ code: String) {
  print("entered code: " + code)
}
```
</details>

<details>
<summary>VisualEffectView</summary>

```swift
// implemented. to be described more

VisualEffectView(.darkBlur)
VisualEffectView(.lightBlur)
VisualEffectView(.extraLightBlur)
// iOS10+
VisualEffectView(.prominent)
VisualEffectView(.regular)

// iOS13+ (but can be used since iOS9+)
// automatic dynamic effect for light and dark modes
VisualEffectView(.darkBlur, .lightBlur) // effect will be switched automatically. darkBlur is for light mode.
```
Create your own extension for your custom effects to use them easily like in example above
```swift
extension UIVisualEffect {
    public static var darkBlur: UIVisualEffect { return UIBlurEffect(style: .dark) }
}
```
</details>

<details>
<summary>WrapperView</summary>

It is simple `View` but with ability to initialize with inner view
```swift
WrapperView {
  View().background(.red).shadow()
}.background(.green).shadow()
```
and you could specify innerView`s padding right here
```swift
// to the same padding for all sides
WrapperView {
  View()
}.padding(10)
// or to specific padding for each side
WrapperView {
  View()
}.padding(top: 10, left: 5, right: 10, bottom: 5)
// or even like this
WrapperView {
  View()
}.padding(top: 10, right: 10)
```
</details>

<details>
<summary>LayerView</summary>

`// implemented. to be described`
</details>

<details>
<summary>Impact Feedback</summary>

My favourite feature.

```swift
ImpactFeedback.error()
ImpactFeedback.success()
ImpactFeedback.selected()
ImpactFeedback.bzz()
```
</details>

<details>
<summary>Localization 🇮🇸🇩🇪🇯🇵🇲🇽</summary>

```swift
// set any localization as default
Localization.default = .en

// override current locale
Localization.current = .en

// create string relative to current language
let myString = String(
    .en("Hello"),
    .fr("Bonjour"),
    .ru("Привет"),
    .es("Hola"),
    .zh_Hans("你好"),
    .ja("こんにちは"))
print(myString)
```

By default current language is equal to `Locale.current` but you can change it by setting `Localizer.current = .en`.
Also localizer have `default` language in case if user's language doesn't match any in your string, and you could set it just by calling `Localizer.default = .en`.

Also you can use localizable strings directly in Button, Text, TextView, TextField and AttributedString
```swift
Text(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))

TextView(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))
    .placeholder(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))

TextField(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))
    .placeholder(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))

Button(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))
Button().title(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"), state: .highlighted)

AttrStr(.en("Hello"), .ru("Привет"), .fr("Bonjour"), .es("Hola"))
```

### But how to use this awesome localization with 10+ languages in the app?

Just create a dedicated localization file (e.g. `Localization.swift`) like this

```swift
extension String {
    static func transferTo(_ wallet: String) -> String {
        String(.en("Transfer to #\(wallet)"),
                  .ru("Перевод на #\(wallet)"),
                  .zh("转移到 #\(wallet)"),
                  .ja("＃\(wallet)に転送"),
                  .es("Transferir a #\(wallet)"),
                  .fr("Transférer au #\(wallet)"),
                  .sv("Överför till #\(wallet)"),
                  .de("Übertragen Sie auf #\(wallet)"),
                  .tr("\(wallet) numarasına aktar"),
                  .it("Trasferimento al n. \(wallet)"),
                  .cs("Převod na #\(wallet)"),
                  .he("\(wallet) העבר למספר"),
                  .ar("\(wallet)#نقل إلى"))
    }
    static var copyLink: String {
        String(.en("Copy link to clipboard"),
                  .ru("Скопировать ссылку"),
                  .zh("复制链接到剪贴板"),
                  .ja("リンクをクリップボードにコピー"),
                  .es("Copiar enlace al portapapeles"),
                  .fr("Copier le lien dans le presse-papiers"),
                  .sv("Kopiera länk till urklipp"),
                  .de("Link in Zwischenablage kopieren"),
                  .tr("Bağlantıyı panoya kopyala"),
                  .it("Copia il link negli appunti"),
                  .cs("Zkopírujte odkaz do schránky"),
                  .he("העתק קישור ללוח"),
                  .ar("نسخ الرابط إلى الحافظة"))
    }
    static var copyLinkSucceeded: String {
        String(.en("Link has been copied to clipboard"),
                  .ru("Ссылка успешно скопирована в буфер обмена"),
                  .zh("链接已复制到剪贴板"),
                  .ja("リンクがクリップボードにコピーされました"),
                  .es("El enlace ha sido copiado al portapapeles"),
                  .fr("Le lien a été copié dans le presse-papiers"),
                  .sv("Länken har kopierats till Urklipp"),
                  .de("Der Link wurde in die Zwischenablage kopiert"),
                  .tr("Bağlantı panoya kopyalandı"),
                  .it("Il link è stato copiato negli appunti"),
                  .cs("Odkaz byl zkopírován do schránky"),
                  .he("הקישור הועתק ללוח"),
                  .ar("تم نسخ الرابط إلى الحافظة"))
    }
    static var shareNumber: String {
        String(.en("Share number"),
                  .ru("Поделиться номером"),
                  .zh("分享号码"),
                  .ja("共有番号"),
                  .es("Compartir número"),
                  .fr("Numéro de partage"),
                  .sv("Aktienummer"),
                  .de("Teilenummer"),
                  .tr("Numarayı paylaş"),
                  .it("Condividi il numero"),
                  .cs("Sdílejte číslo"),
                  .he("מספר שתף"),
                  .ar("رقم السهم"))
    }
    static var shareLink: String {
        String(.en("Share link"),
                  .ru("Поделиться ссылкой"),
                  .zh("分享链接"),
                  .ja("共有リンク"),
                  .es("Compartir enlace"),
                  .fr("Lien de partage"),
                  .sv("Dela länk"),
                  .de("Einen Link teilen"),
                  .tr("Linki paylaş"),
                  .it("Condividi il link"),
                  .cs("Sdílet odkaz"),
                  .he("שתף קישור"),
                  .ar("مشاركة الرابط"))
    }
}
```

And then use localized string all over the app this easy way

```swift
Text(.transferTo("123")) // Transfer to #123
Text(.copyLinkSucceeded) // Copy link to clipboard
Button(.shareNumber) // Share number
Button(.shareLink) // Share link
```
</details>

<details>
<summary>View Controller</summary>

`// implemented. to be described`
</details>

<details>
<summary>Status bar style</summary>

In any `ViewController` you can set `statusBarStyle` and all its values are iOS9+.
```swift
override var statusBarStyle: StatusBarStyle { .default }
override var statusBarStyle: StatusBarStyle { .dark }
override var statusBarStyle: StatusBarStyle { .light }
```
</details>

<details>
<summary>Colors</summary>

```swift
/// Simple color
UIColor.red

/// Automatic dynamic color: black for light mode, white for dark mode
UIColor.black / UIColor.white

/// color in hex, represented as int and supported by all color properties
0xFF0000

/// hex color converted to UIColor
0xFF0000.color

/// hex colors as dynamic UIColor
0x000.color / 0xfff.color

/// color with alpha
UIColor.white.alpha(0.5)

/// hex color with alpha
0xFFFFFF.color.alpha(0.5)
```

Declare custom colors like this
```swift
import UIKit
import UIKitPlus

extension UIColor {
    static var mainBlack: UIColor { return .black  }
    static var otherGreen: UIColor { return 0x3D7227.color  } // 61 114 39
}
```
and then use them just like
```swift
Label("Hello world").color(.otherGreen).background(.mainBlack)
```
</details>

<details>
<summary>Fonts</summary>

```swift
// implemented. to be described

/// helper to print all the fonts in console (debug only)
UIFont.printAll()
```

Add your custom fonts to the project and then declare them like this
```swift
import UIKitPlus

extension FontIdentifier {
    public static var sfProBold = FontIdentifier("SFProDisplay-Bold")
    public static var sfProRegular = FontIdentifier("SFProDisplay-Regular")
    public static var sfProMedium = FontIdentifier("SFProDisplay-Medium")
}
```
and then use them just like
```swift
Button().font(.sfProMedium, 15)
```
</details>

<details>
<summary>Gestures</summary>

[Detailed instruction](Docs/Gestures.md)
</details>

<details>
<summary>States</summary>

> alias is `UState`

```swift
/// usual
@State var myState = UIColor.red
@State var myState = ""
@State var myState = 0
// etc.

/// expressable
$boolStateToColor.map { $0 == true ? .red : .green }
$boolStateToString.map { !$0 ? "night" : "day" }

/// mix to Int states into one String expressable
$state1.and($state2).map { $0.left > $0.right ? "higher" : "lower" }
```
</details>

<details>
<summary>Attributed Strings</summary>

```swift
AttributedString("hello").background(.gray)
                         .foreground(.red)
                         .font(.sfProBold, 15)
                         .paragraphStyle(.default)
                         .ligature(1)
                         .kern(1)
                         .strikethroughStyle(1)
                         .underlineStyle(.patternDash)
                         .strokeColor(.purple)
                         .strokeWidth(1)
                         .shadow()
                   // or .shadow(offset: .zero, blur: 1, color: .lightGray)
                         .textEffect("someEffect")
                         .attachment(someAttachment)
                         .link("http://github.com")
                         .baselineOffset(1)
                         .underlineColor(.cyan)
                         .strikethroughColor(.magenta)
                         .obliqueness(1)
                         .expansion(1)
                         .glyphForm(.horizontal)
                         .writingDirection(.rightToLeft)

/// also use shorter alias
AttrStr("hello").foreground(.red)
// or even just
"hello".foreground(.red)
```
</details>

<details>
<summary>Animations</summary>

`// implemented. to be described`
</details>

<details>
<summary>Activity Indicator</summary>

`// implemented. to be described`
</details>

<details>
<summary>Bar Button Item</summary>

`// implemented. to be described`
</details>

<details>
<summary>Button</summary>

> alias is `UButton`

`// to be described more`

```swift
Button()
Button("Tap me")
Button().title("Tap me") // useful if you declared Button from extension like below
Button.mySuperButton.title("Tap me")
```
background and background for highlighted state
```swift
Button("Tap me").background(.white).backgroundHighlighted(.darkGray)
```
title color for different states
```swift
Button("Tap me").color(.black).color(.lightGray, .disabled)
```
set some font from declared identifiers or with system fonts
```swift
Button("Tap me").font(v: .systemFont(ofSize: 15))
Button("Tap me").font(.sfProBold, 15)
```
add image
```swift
Button("Tap me").image(UIImage(named: "cat"))
Button("Tap me").image("cat")
```
You can handle tap action easily
```swift
Button("Tap me").onTapGesture { print("button tapped") }
Button("Tap me").onTapGesture { button in
    print("button tapped")
}
```
or like this
```swift
func tapped() { print("button tapped") }
Button("Tap me").onTapGesture(tapped)

func tapped(_ button: Button) { print("button tapped") }
Button("Tap me").onTapGesture(tapped)
```

Declare custom buttons like this
```swift
import UIKitPlus

extension Button {
    static var bigBottomWhite: Button {
        return Button().color(.darkGray).color(.black, .highlighted).font(.sfProMedium, 15).background(.white).backgroundHighlighted(.lightGray).circle()
    }
    static var bigBottomGreen: Button {
        return Button().color(.white).font(.sfProMedium, 15).background(.mainGreen).circle()
    }
}
```
and then use them like this
```swift
Button.bigBottomWhite.size(300, 50).bottomToSuperview(20).centerInSuperview()
```
</details>

<details>
<summary>Collection</summary>

```swift
// implemented. to be described

// difference between Collection and CollectionView
// flow layouts
```
</details>

<details>
<summary>ControlView</summary>

`// implemented. to be described`
</details>

<details>
<summary>DatePicker</summary>

`// implemented. to be described`
</details>

<details>
<summary>DynamicPickerView</summary>

`// implemented. to be described`
</details>

<details>
<summary>StackView</summary>

> alias is `UStackView`

`// implemented. to be described`

```swift
StackView().axis(.vertical)
           .alignment(.fill)
           .distribution(.fillEqually)
           .spacing(16)
```
</details>

<details>
<summary>VStack</summary>

> alias is `UVStack`

`// implemented. to be described more`
The same as `StackView` but with predefined axis and ability to easily add arranged subviews
```swift
VStack (
  Text("hello world").background(.green),
  VSpace(16) // 16pt delimiter
  Text("hello world").background(.red)
)
.spacing(10)
.alignment(.left)
.distribution(...)
```
</details>

<details>
<summary>VScrollStack</summary>

```swift
// implemented. to be described

/// it is the same as VStack but it is combined with ScrollView
```
</details>

<details>
<summary>HStack</summary>

> alias is `UHStack`

`// implemented. to be described more`
The same as `StackView` but with predefined axis and ability to easily add arranged subviews
```swift
HStack (
  Text("hello world").background(.green),
  HSpace(16) // 16pt delimiter
  Text("hello world").background(.red)
)
.spacing(10)
.alignment(.left)
.distribution(...)
```
</details>

<details>
<summary>HScrollStack</summary>

```swift
// implemented. to be described

/// it is the same as HStack but it is combined with ScrollView
```
</details>

<details>
<summary>HSpace</summary>

```swift
/// just a horizontal delimiter
HSpace(16)
/// alternatively
View().width(16)
```
</details>

<details>
<summary>VSpace</summary>

```swift
/// just a vertical delimiter
VSpace(16)
/// alternatively
View().height(16)
```
</details>

<details>
<summary>Space</summary>

```swift
/// just a flexible space for stack views
Space()
/// alternatively
View()
```
</details>

<details>
<summary>HUD</summary>

`// implemented. to be described`
</details>

<details>
<summary>Image</summary>

> alias is `UImage`

`// to be described more`

Declare asset images like this
```swift
import UIKitPlus

extension Image {
    static var welcomeBackground: Image { return Image("WelcomeBackground") }
}
```
and then use them like this
```swift
let backgroudImage = Image.welcomeBackground.edgesToSuperview()
```

#### With built-in `ImageLoader`

```swift
Image(url: "")
Image(url: "", defaultImage: UIImage(named: "emptyImage")) // set default image to show it while loading
Image(url: "", loader: .defaultRelease) // release image before start loading
Image(url: "", loader: .defaultImmediate) // immediate replace image after loading
Image(url: "", loader: .defaultFade) // replace image with fade effect after loading
Image(url: "", loader: ImageLoader()) // subclass from `ImageLoader` and set you custom loader here
```
</details>

<details>
<summary>InputView</summary>

`// implemented. to be described`
</details>

<details>
<summary>List</summary>

> alias is `UList`

```swift
// implemented. to be described

also describe auto-DIFF with Identable models
```
</details>

<details>
<summary>TableView</summary>

`// implemented. to be described`
</details>

<details>
<summary>PickerView</summary>

`// implemented. to be described`
</details>

<details>
<summary>RefreshControl</summary>

`// implemented. to be described`
</details>

<details>
<summary>ScrollView</summary>

`// implemented. to be described more`
```swift
ScrollView().paging(true).scrolling(false).hideIndicator(.horizontal)
ScrollView().paging(true).scrolling(false).hideAllIndicators()
ScrollView().contentInset(.zero)
ScrollView().contentInset(top: 10, left: 5, right: 5, bottom: 10)
ScrollView().contentInset(top: 10, bottom: 10)
ScrollView().scrollIndicatorInsets(.zero)
ScrollView().scrollIndicatorInsets(top: 10, left: 5, right: 5, bottom: 10)
ScrollView().scrollIndicatorInsets(top: 10, bottom: 10)
```
</details>

<details>
<summary>SegmentedControl</summary>

> alias is `USegmentedControl`

`// implemented. to be described more`
```swift
@State var selectedItem = 0
SegmentedControl("One", "Two").select($selectedItem)
// or simply
SegmentedControl("One", "Two").select(0).changed { print("segment changed to \($0)") }
```
</details>

<details>
<summary>SliderView</summary>

`// implemented. to be described`
</details>

<details>
<summary>Stepper</summary>

> alias is `UStepper`

`// implemented. to be described`
</details>

<details>
<summary>TextField</summary>

> alias is `UTextField`

```swift
// implemented. to be described

// format with AnyFormat
```

```swift
TextField()
TextField("some text")
TextField().text("some text")
TextField.mySuperDuperTextField.text("some text")
```
set some font from declared identifiers or with system fonts
```swift
TextField().font(v: .systemFont(ofSize: 15))
TextField().font(.sfProBold, 15)
```
set text color
```swift
TextField().color(.red)
```
set text alignment
```swift
TextField().alignment(.center)
```
placeholder
```swift
TextField().placeholder("email")
// or use AttributedString to make it colored
TextField().placeholder(AttributedString("email").foreground(.green))
```
secure
```swift
TextField().secure()
```
remove any text from field easily
```swift
TextField().cleanup()
```
set keyboard and content type
```swift
TextField().keyboard(.emailAddress).content(.emailAddress)
```
set delegate
```swift
TextField().delegate(self)
```
or get needed events declarative way
```swift
TextField().shouldBeginEditing { tf in return true }
           .didBeginEditing { tf in }
           .shouldEndEditing { tf in return true }
           .didEndEditing { tf in }
           .shouldChangeCharacters { tf, range, replacement in return true }
           .shouldClear { tf in return true }
           .shouldReturn { tf in return true }
           .editingDidBegin { tf in }
           .editingChanged { tf in }
           .editingDidEnd { tf in }
```
</details>

<details>
<summary>Text (aka UILabel)</summary>

> alias is `UText` or just `Label`

`// to be described more`
It either may be initialized with `String` or unlimited amount of `AttributedString`s
```swift
Label("hello 👋 ")
Label().text("hello") // useful if declare label in extension like below
Label.mySuperLabel.text("hello")
Label("hello".foreground(.red), "world".foreground(.green))
```
set some font from declared identifiers or with system fonts
```swift
Label("hello").font(v: .systemFont(ofSize: 15))
Label("hello").font(.sfProBold, 15)
```
set text color
```swift
Label("hello").color(.red)
```
set text alignment
```swift
Label("hello").alignment(.center)
```
set amount of lines
```swift
Label("hello").lines(1)
Label("hello\nworld").lines(0)
Label("hello\nworld").lines(2)
Label("hello\nworld").multiline()
```

Declare custom attributed labels like this
```swift
import UIKitPlus

extension Label {
    static var welcomeLogo: Label {
        return .init(AttributedString("My").foreground(.white).font(.sfProBold, 26),
                     AttributedString("App").font(.sfProBold, 26))
    }
}
```
and then use them like this
```swift
let logo = Label.welcomeLogo.centerInSuperview()
```
</details>

<details>
<summary>TextView</summary>

> alias is `UTextView`

`// implemented. to be described`
</details>

<details>
<summary>Toggle</summary>

> alias is `UToggle`

`// implemented. to be described`
</details>

#### Properties

All the properties are available to be set declaratively and can be binded to `State` or `ExpressableState`.

A lot of layer properties are available directly and have convenient initializers.

<details>
<summary>Alpha</summary>

```swift
View().alpha(0)
View().alpha($alphaState)
View().alpha($boolState.map { $0 ? 1 : 0 })
```
</details>

<details>
<summary>Background</summary>

```swift
View().background(.red)
View().background(0xff0000)
View().background($colorState)
View().background($boolState.map { $0 ? .red : .green })
```
</details>

<details>
<summary>Borders</summary>

To set border on all sides
```swift
View().border(1, .black)
View().border(1, 0x000)
```
To set border on specific side
```swift
View().border(.top, 1, .black)
View().border(.left, 1, .black)
View().border(.right, 1, .black)
View().border(.bottom, 1, .black)
```
To remove border from specific side
```swift
.removeBorder(.top)
```
</details>

<details>
<summary>Bounds</summary>

```swift
// implemented. to be described
```
</details>

<details>
<summary>Compression Resistance</summary>

```swift
// implemented. to be described
```
</details>

<details>
<summary>Corners</summary>

To set radius to all corners
```swift
View().corners(10)
View().corners($cornerRadiusState)
```
To set custom radius for specific corner
```swift
View().corners(10, .topLeft, .topRight)
View().corners(10, .topLeft, .bottomRight)
View().corners(10, .topLeft, .topRight, .bottomLeft, .bottomRight)
```
To make your view's corners round automatically by smaller side
```swift
View().circle()
```
</details>

<details>
<summary>Hidden</summary>

```swift
View().hidden() // will set `true` by default
View().hidden(true)
View().hidden(false)
View().hidden($hiddenState)
View().hidden($stringState.map { $0.count > 0 })
```
</details>

<details>
<summary>Hugging Priority</summary>

```swift
// implemented. to be described
```
</details>

<details>
<summary>Itself</summary>

```swift
// implemented. to be described
```
</details>

<details>
<summary>Layout Margin</summary>

```swift
// to all sides
View().layoutMargin(10)
// optional sides
View().layoutMargin(top: 10)
View().layoutMargin(left: 10, bottom: 5)
View().layoutMargin(top: 10, right: 5)
// vertical and horizontal
View().layoutMargin(x: 10, y: 5) // top: 5, left: 10, right: 10, bottom: 5
View().layoutMargin(x: 10) // left: 10, right: 10
View().layoutMargin(y: 5) // top: 5, bottom: 5
```
</details>

<details>
<summary>Focus to next responder or resign</summary>

```swift
// implemented. to be described
```
</details>

<details>
<summary>Opacity</summary>

```swift
View().opacity(0)
View().opacity($alphaState)
View().opacity($boolState.map { $0 ? 1 : 0 })
```
</details>

<details>
<summary>Rasterize</summary>

To rasterize layer, e.g. for better shadow performance
```swift
View().rasterize() // true by default
View().rasterize(true)
View().rasterize(false)
```
</details>

<details>
<summary>Shadow</summary>

```swift
// to be described more

// and with mroe than one shadow
// and with state, expressableState
```
```swift
View().shadow() // by default it's black, opacity 1, zero offset, radius 10
View().shadow(.gray, opacity: 0.8, offset: .zero, radius: 5)
View().shadow(0x000000, opacity: 0.8, offset: .zero, radius: 5)
```
</details>

<details>
<summary>Shake</summary>

You can shake any view just by calling
```swift
View().shake()
```
And you could customize shake effect
```swift
View().shake(values: [-20, 20, -20, 20, -10, 10, -5, 5, 0],
             duration: 0.6,
             axis: .horizontal,
             timing: .easeInEaseOut)
View().shake(-20, 20, -20, 20, -10, 10, -5, 5, 0,
             duration: 0.6,
             axis: .horizontal,
             timing: .easeInEaseOut)
```
or even create an extension
```swift
import UIKitPlus

extension DeclarativeProtocol {
  func myShake() {
      View().shake(-20, 20, -20, 20, -10, 10, -5, 5, 0,
                   duration: 0.6,
                   axis: .horizontal,
                   timing: .easeInEaseOut)
  }
}
```
</details>

<details>
<summary>Tag</summary>

```swift
View().tag(0)
```
</details>

<details>
<summary>Tint</summary>

```swift
View().tint(.red)
View().tint(0xff0000)
View().tint($colorState)
View().tint($boolState.map { $0 ? .red : .green })
```
</details>

<details>
<summary>User Interaction</summary>

```swift
// implemented. to be described
```
</details>

# Examples

[Example app is here](https://github.com/MihaelIsaev/UIKitPlusExample)

## Example 1
```swift
import UIKitPlus

class MyViewController: ViewController {
    lazy var view1 = View()

    override func buildUI() {
        super.buildUI()
        body {
            view1.background(.black).size(100).centerInSuperview()
            View().background(.red).size(30, 20).centerXInSuperview().top(to: .bottom, of: view1, 16)
        }
    }
}
```
## Example 2
```swift
import UIKitPlus

// Just feel how easy you could build & declare your views
// with all needed constraints, properties and actions
// even before adding them to superview!
class LoginViewController: ViewController {
    @State var email = ""
    @State var password = ""

    override func buildUI() {
        super.buildUI()
        view.backgroundColor = .black
        body {
            Button.back.onTapGesture { print("back tapped") }
            Label.welcome.text("Welcome").centerXInSuperview().topToSuperview(62, safeArea: true)
            VStack {
                TextField.welcome.text($email).placeholder("Email").keyboard(.emailAddress).content(.emailAddress)
                TextField.welcome.text($password).placeholder("Password").content(.password).secure()
                View().height(10) // just to add extra space
                Button.bigBottomGreen.title("Sign In").onTapGesture(signIn)
            }.edgesToSuperview(top: 120, leading: 16, trailing: -16)
        }
    }

    func signIn() {
        // do an API call to your server with awesome CodyFire lib 😉
    }
}
```
And you just need a few extensions to make it work
```swift
// PRO-TIP:
// To avoid mess declare reusable views in extensions like this
extension FontIdentifier {
    static var sfProRegular = FontIdentifier("SFProDisplay-Regular")
    static var sfProMedium = FontIdentifier("SFProDisplay-Medium")
}
extension Text {
    static var title: Text { Text().color(.white).font(.sfProMedium, 18) }
}
extension TextField {
    static var welcome: TextField {
        TextField()
            .height(40)
            .background(.clear)
            .color(.black)
            .tint(.mainGreen)
            .border(.bottom, 1, .gray)
            .font(.sfProRegular, 16)
    }
}
extension Button {
    static var back: Button { return Button("backIcon").topToSuperview(64).leadingToSuperview(24) }
    static var bigBottomGreen: Button {
        Button()
            .color(.white)
            .font(.sfProMedium, 15)
            .background(.green)
            .height(50)
            .circle()
            .shadow(.gray, opacity: 1, offset: .init(width: 0, height: -1), radius: 10)
    }
}

// PRO-TIP2:
// I'd suggest you to use extensions for everything: fonts, images, labels, buttons, colors, etc.
```
