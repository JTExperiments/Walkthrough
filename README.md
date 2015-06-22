# CompactAnimation

Compact syntax, making CoreAnimation more writable

You write

```swift
let fadeIn = B.fade(by: 1).begin(0).duration(1)
let scale = B.scale(from: 0, to: 1).duration(1)
let appear = G.combine(fadeIn, scale)
let move = B.move(by: CGPointMake(screenSize.width + 50, 0)).duration(1).begin(1)
let disappear = S.scale(to: 0).begin(5).duration(1)
let timeline = G.combine(appear,move,disappear).duration(6)
return timeline
```
Instead of
```swift

let fadeIn = CABasicAnimation(keyPath: "opacity")
fadeIn.fromValue = 0
fadeIn.toValue = 1
fadeIn.duration = 1
fadeIn.fillMode = kCAFillModeForwards
fadeIn.removedOnCompletion = false

let scaleUp = CASpringAnimation(keyPath: "transform.scale")
scaleUp.fromValue = 0
scaleUp.toValue = 1
scaleUp.duration = 1
scaleUp.fillMode = kCAFillModeForwards
scaleUp.removedOnCompletion = false

let appear = CAAnimationGroup()
appear.animations = [fadeIn, scaleUp]
appear.duration = 1
appear.fillMode = kCAFillModeForwards
appear.removedOnCompletion = false

let move = CABasicAnimation(keyPath: "position")
move.byValue = NSValue(CGPoint:CGPointMake(screenSize.width + 50, 0))
move.duration = 1
move.beginTime = 1
move.fillMode = kCAFillModeForwards
move.removedOnCompletion = false

let disappear = CASpringAnimation(keyPath: "transform.scale")
disappear.toValue = NSValue(CGSize: CGSizeMake(0, 0))
disappear.duration = 1
disappear.beginTime = 5
disappear.fillMode = kCAFillModeForwards
disappear.removedOnCompletion = false

let appIcon1Timeline = CAAnimationGroup()
appIcon1Timeline.animations = [appear, move, disappear]
appIcon1Timeline.duration = 6
appIcon1Timeline.fillMode = kCAFillModeForwards
appIcon1Timeline.removedOnCompletion = false

return appIcon1Timeline
```

Keyframe examples:
```swift
let position = K.move { (config) -> () in
    config(keyTime: 0.0/6.0).to(CGPointMake(screenSize.width + 50, 250))
    config(keyTime: 1.5/6.0).to(CGPointMake(screenSize.width + 50, 250))
    config(keyTime: 2.0/6.0).to(CGPointMake(125, 250))
    config(keyTime: 3.0/6.0).to(CGPointMake(125 - screenSize.width, 250))
    }.duration(6)
```
```swift
let position = CAKeyframeAnimation(keyPath: "position")
position.values = [
    NSValue(CGPoint: CGPointMake(screenSize.width + 50, 250)),
    NSValue(CGPoint: CGPointMake(screenSize.width + 50, 250)),
    NSValue(CGPoint: CGPointMake(125, 250)),
    NSValue(CGPoint: CGPointMake(125 - screenSize.width, 250)),
]
position.keyTimes = [
    0,
    1.5/6.0,
    2.0/6.0,
    3.0/6.0,
]
position.fillMode = kCAFillModeForwards
position.removedOnCompletion = false
position.duration = 6
```

What's done

- CABasicAnimation
  - fade = "opacity"
  - scale = "transform.scale"
  - move = "position"

- CASpringAnimation : CABasicAnimation

- CAKeyFrameAnimation
  - move

- CAAnimationGroup
    - combine(animations: CAAnimation, ...)

- CAMediaTimingFunction
  - linear()
  - easeIn()
  - easeOut()
  - easeInOut()
  - defaultTiming()
  - timing(timingFunction:)
