We support all available gestures

### TapGestureRecognizer

```swift
TapGestureRecognizer(taps: 1, touches: 1)
```
or
```swift
TapGestureRecognizer()
    .numberOfTapsRequired(1)
    .numberOfTouchesRequired(1)
```
> 💡`numberOfTapsRequired` and `numberOfTouchesRequired` also accept `@State`

also you can conveniently call `onTapGesture` at any view
```swift
.onTapGesture {}
.onTapGesture { view in }
.onTapGesture { view, state in }
.onTapGesture { view, state, recognizer in }
.onTapGesture(taps: 1, touches: 1) { view, state in }
.onTapGesture(taps: 1, touches: 1) { view, state, recognizer in }
.onTapGesture(taps: 1, touches: 1, $someState)
.onTapGesture(taps: 1, touches: 1, on: .ended) { }
.onTapGesture(taps: 1, touches: 1, on: .ended) { view in }
```

### LongPressGestureRecognizer

```swift
LongPressGestureRecognizer(taps: 0, touches: 1, minDuration: nil, allowableMovement: nil)
```
or
```swift
LongPressGestureRecognizer(taps: 0, touches: 1)
    .minimumPressDuration(500)
    .allowableMovement(10)
```
> 💡`minimumPressDuration ` and `allowableMovement ` also accept `@State`

also you can conveniently call `onLongPressGesture ` at any view
```swift
.onLongPressGesture { view in }
.onLongPressGesture { view, state in }
.onLongPressGesture { view, state, recognizer in }
.onLongPressGesture(taps: 1, touches: 1) { view, state in }
.onLongPressGesture(taps: 1, touches: 1) { view, state, recognizer in }
.onLongPressGesture(taps: 1, touches: 1, $someState)
.onLongPressGesture(taps: 1, touches: 1, on: .ended) { }
.onLongPressGesture(taps: 1, touches: 1, on: .ended) { view in }
```

### PinchGestureRecognizer

```swift
PinchGestureRecognizer(scale: 10)
```
or
```swift
PinchGestureRecognizer().scale(10)
```
> 💡`scale ` also accept `@State`

also you can conveniently call `onPinchGesture` at any view

```swift
// there are a lot of convenient combinations of this method
.onPinchGesture { view, state, recognizer in
    print("changed scale: \(recognizer.scale) velocity: \(recognizer.velocity)")
    view.size(200 * r.scale)
}
```

### RotationGestureRecognizer

```swift
RotationGestureRecognizer(rotation: 2)
```
or
```swift
RotationGestureRecognizer().rotation(2)
```
> 💡`rotation ` also accept `@State`

also you can conveniently call `onRotationGesture` at any view

```swift
// there are a lot of convenient combinations of this method
.onRotationGesture { view, state, recognizer in
    if state == .changed {
        view.transform = CGAffineTransform(rotationAngle: recognizer.rotation)
    }
}
```

### SwipeGestureRecognizer

```swift
SwipeGestureRecognizer(direction: .left, touches: nil)
```
or
```swift
SwipeGestureRecognizer(direction: .left)
    .numberOfTouchesRequired(1)
```
> 💡`numberOfTouchesRequired ` also accept `@State`

also you can conveniently call `onSwipeGesture` at any view

```swift
// there are a lot of convenient combinations of this method
.onSwipeGesture(direction: .left) { view, state, recognizer in }
```

### PanGestureRecognizer

```swift
PanGestureRecognizer(minTouches: 1, maxTouches: 2)
```
or
```swift
PanGestureRecognizer()
    .minimumNumberOfTouches(1)
    .maximumNumberOfTouches(1)
```
> 💡`minimumNumberOfTouches ` and `maximumNumberOfTouches ` also accept `@State`

also you can conveniently call `onPanGesture` at any view

```swift
// there are a lot of convenient combinations of this method
.onPanGesture { view, state, recognizer in }
```

### ScreenEdgePanGestureRecognizer

```swift
ScreenEdgePanGestureRecognizer(edges: .all)
```
and additional `.edges` method gives you an ability to change edges property later
```swift
.edges(.left)
```
> 💡`edges` also accept `@State`

also you can conveniently call `onScreenEdgePanGesture` at any view

```swift
// there are a lot of convenient combinations of this method
.onScreenEdgePanGesture(edges: .left) { view, state, recognizer in }
```

### HoverGestureRecognizer

```swift
HoverGestureRecognizer()
```

you can conveniently call `onHoverGesture` or `hovered` at any view

```swift
.hovered {
    print("hovered: \($0)")
}
```
or
```swift
.onHoverGesture { view, state, recognizer in
        switch state {
        case .began:
            print("began")
            view.backgroundColor = .magenta
        case .changed:
            print("changed")
            view.backgroundColor = .orange
        case .ended:
            print("ended")
            view.backgroundColor = .green
        default: print("default")
        }
}
```

### State tracking

Any gesture recognizer has tracking methods

There are universal `trackState` method which contains `state` and optionally `recognizer`

```swift
.trackState { state, recognizer in
    // do switch/case here
}
```

> 💡`trackState` can accept `@State`

And additionally you have an ability to listen for exact state easily 👍

```swift
.onPossible { recognizer in }
.onBegan { recognizer in }
.onChanged { recognizer in }
.onEnded { recognizer in }
.onCancelled { recognizer in }
.onFailed { recognizer in }
```
> 💡`recognizer` is optional

### Delegate

Any gesture recognizer has its delegate methods available directly

You can set delegate simply like this
```swift
.delegate(...)
```

Additionally you can use these convenient methods below and even combine them with the classic delegate

```swift
.shouldBegin { recognizer in
    return true
}
.shouldReceivePress { recognizer, press in
    return true
}
.shouldReceiveTouch { recognizer, touch in
    return true
}
.shouldRequireFailureOfOtherGestureRecognizer { currentRecognizer, otherRecognizer in
    return false
}
.shouldBeRequiredToFailByOtherGestureRecognizer { currentRecognizer, otherRecognizer in
    return false
}
.shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { currentRecognizer, otherRecognizer in
    return true
}
```

### Tags

You can set `tag` for any gesture recognizer

```swift
TapGestureRecognizer().tag(777)
```

and then you can read it easily somewhere, e.g.

```swift
.shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { otherRecognizer in
    print("shouldRecognizeSimultaneouslyWith: \(otherRecognizer.tag)")
    return true
}
```

### How to add a gesture to view

```swift
UView().gesture(myGesture)
```
or
```swift
UView().gestures(myGesture1, myGesture2)
```
or even
```swift
UView().gestures {
    myGesture1
    myGesture2
    // unlimited amount
}
```

### Multiple gestures at the same time (simple example for pinch + rotate)

```swift
UView().size(200).background(.red).centerInSuperview().gestures { v in
    PinchGestureRecognizer().shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { og in
        print("PinchGestureRecognizer shouldRecognizeSimultaneouslyWith: \(og.tag)")
        return true
    }.trackState { s, r in
        if s == .changed {
            v.size(200 * r.scale)
        }
    }.tag(3)
    RotationGestureRecognizer().shouldRecognizeSimultaneouslyWithOtherGestureRecognizer { og in
        print("PinchGestureRecognizer shouldRecognizeSimultaneouslyWith: \(og.tag)")
        return true
    }.trackState { s, r in
        if s == .changed {
            v.transform = CGAffineTransform(rotationAngle: r.rotation)
        }
    }.tag(4)
}
```

### View's touch methods which available without gesture recognizers

```swift
.touchesBegan { view, touch, event in }
.touchesMoved { view, touch, event in }
.touchesEnded { view, touch, event in }
.touchesCancelled { view, touch, event in }
```

> 💡 All the methods above has its convenient shorter variations
