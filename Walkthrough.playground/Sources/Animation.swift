import UIKit

public func createAppIcon2Animation(screenSize: CGSize) -> CAAnimation {

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

    return position
}

public func createAppIconAnimation(screenSize: CGSize) -> CAAnimation {

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
}


public func createIPhoneAnimation(screenSize: CGSize) -> CAAnimation {

    let moveLeft = CABasicAnimation(keyPath: "position")
    moveLeft.byValue = NSValue(CGPoint:CGPointMake(-screenSize.width, 0))
    moveLeft.duration = 1
    moveLeft.beginTime = 1
    moveLeft.fillMode = kCAFillModeForwards
    moveLeft.removedOnCompletion = false


    let moveUp = CABasicAnimation(keyPath: "position")
    moveUp.fromValue = NSValue(CGPoint: CGPointMake(screenSize.width/2, screenSize.height + 180))
    moveUp.toValue = NSValue(CGPoint: CGPointMake(screenSize.width/2, screenSize.height))
    moveUp.beginTime = 2.2
    moveUp.duration = 0.8
    moveUp.fillMode = kCAFillModeForwards
    moveUp.removedOnCompletion = false

    let moveLeft2 = CABasicAnimation(keyPath: "position")
    moveLeft2.byValue = NSValue(CGPoint: CGPointMake(-screenSize.width, 0))
    moveLeft2.beginTime = 3.0
    moveLeft2.duration = 1.0
    moveLeft2.fillMode = kCAFillModeForwards
    moveLeft2.removedOnCompletion = false


    let iphoneTimeline = CAAnimationGroup()
    iphoneTimeline.animations = [moveLeft, moveUp, moveLeft2]
    iphoneTimeline.duration = 6
    iphoneTimeline.fillMode = kCAFillModeForwards
    iphoneTimeline.removedOnCompletion = false

    return iphoneTimeline
}

public func createAppIcon3Animation(screenSize: CGSize) -> CAAnimation {

    let move = CAKeyframeAnimation(keyPath: "position")
    move.keyTimes = [
        0.0/6.0,
        2.0/6.0,
        3.0/6.0,
        4.0/6.0,
        5.0/6.0
    ]
    move.values = [
        NSValue(CGPoint: CGPointMake(screenSize.width/2, screenSize.height + 64)),
        NSValue(CGPoint: CGPointMake(screenSize.width/2, screenSize.height + 64)),
        NSValue(CGPoint: CGPointMake(75, 320)),
        NSValue(CGPoint: CGPointMake(100, 320)),
        NSValue(CGPoint: CGPointMake(100 - screenSize.width, 320)),
    ]
    move.duration = 6
    move.fillMode = kCAFillModeForwards
    move.removedOnCompletion = false

    let scaleUp = CABasicAnimation(keyPath: "transform.scale")
    scaleUp.toValue = 1.7
    scaleUp.beginTime = 2.0
    scaleUp.duration = 1.0
    scaleUp.fillMode = kCAFillModeForwards
    scaleUp.removedOnCompletion = false

    let scaleDown = CABasicAnimation(keyPath: "transform.scale")
    scaleDown.toValue = 0.0
    scaleDown.beginTime = 3.0
    scaleDown.duration = 0.8
    scaleDown.fillMode = kCAFillModeForwards
    scaleDown.removedOnCompletion = false

    let group = CAAnimationGroup()
    group.animations = [move, scaleUp, scaleDown]
    group.duration = 6
    group.fillMode = kCAFillModeForwards
    group.removedOnCompletion = false

    return group
}

public func createCircleAnimation(screenSize: CGSize) -> CAAnimation {
    let moveCenter = CABasicAnimation(keyPath: "position")
    moveCenter.fromValue = NSValue(CGPoint: CGPointMake(screenSize.width/2 + screenSize.width, screenSize.height/2 - 20))
    moveCenter.toValue = NSValue(CGPoint: CGPointMake(screenSize.width/2, screenSize.height/2 - 20))
    moveCenter.beginTime = 3
    moveCenter.duration = 1.0
    moveCenter.fillMode = kCAFillModeForwards
    moveCenter.removedOnCompletion = false

    let moveLeft = CABasicAnimation(keyPath: "position")
    moveLeft.byValue = NSValue(CGPoint: CGPointMake(-screenSize.width, 0))
    moveLeft.beginTime = 4
    moveLeft.duration = 1.0
    moveLeft.fillMode = kCAFillModeForwards
    moveLeft.removedOnCompletion = false

    let group = CAAnimationGroup()
    group.animations = [moveCenter, moveLeft]
    group.duration = 6.0
    group.fillMode = kCAFillModeForwards
    group.removedOnCompletion = false

    return group
}


public func createButtonAnimation(screenSize: CGSize) -> CAAnimation {
    let moveCenter = CABasicAnimation(keyPath: "position")
    moveCenter.fromValue = NSValue(CGPoint: CGPointMake(screenSize.width/2 + screenSize.width + 100, screenSize.height/2 + 160))
    moveCenter.toValue = NSValue(CGPoint: CGPointMake(screenSize.width/2 - screenSize.width - 100, screenSize.height/2 + 160))
    moveCenter.beginTime = 3
    moveCenter.duration = 2.0
    moveCenter.fillMode = kCAFillModeForwards
    moveCenter.removedOnCompletion = false

    let group = CAAnimationGroup()
    group.animations = [moveCenter]
    group.fillMode = kCAFillModeForwards
    group.removedOnCompletion = false
    group.duration = 6.0
    
    return group
}

