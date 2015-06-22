import UIKit

public func createAppIcon2Animation(screenSize: CGSize) -> CAAnimation {
    let position = K.move { (config) -> () in
        config(keyTime: 0.0/6.0).to(CGPointMake(screenSize.width + 50, 250))
        config(keyTime: 1.5/6.0).to(CGPointMake(screenSize.width + 50, 250))
        config(keyTime: 2.0/6.0).to(CGPointMake(125, 250))
        config(keyTime: 3.0/6.0).to(CGPointMake(125 - screenSize.width, 250))
        }.duration(6)
    return position
}

public func createAppIconAnimation(screenSize: CGSize) -> CAAnimation {
    let fadeIn = B.fade(by: 1).begin(0).duration(1)
    let scale = B.scale(from: 0, to: 1).duration(1)
    let appear = G.combine(fadeIn, scale)

    let move = B.move(by: CGPointMake(screenSize.width + 50, 0)).duration(1).begin(1)

    let disappear = S.scale(to: 0).begin(5).duration(1)

    let timeline = G.combine(appear,move,disappear).duration(6)
    return timeline
}


public func createIPhoneAnimation(screenSize: CGSize) -> CAAnimation {
    let moveLeft = B.move(by: CGPointMake(-screenSize.width, 0)).duration(1).begin(1)
    let moveUp = B.move(
        from: CGPointMake(screenSize.width/2, screenSize.height + 180),
        to: CGPointMake(screenSize.width/2, screenSize.height))
        .begin(2.2)
        .duration(0.8)

    let moveLeft2 = B.move(by: CGPointMake(-screenSize.width, 0))
        .begin(3)
        .duration(1)

    let timeline = G.combine(moveLeft, moveUp, moveLeft2).duration(6)
    return timeline
}

public func createAppIcon3Animation(screenSize: CGSize) -> CAAnimation {
    let move = K.move { (config) -> () in
        config(keyTime: 0.0/6.0).to(CGPointMake(screenSize.width / 2, screenSize.height + 64)).easeInOut()
        config(keyTime: 2.0/6.0).to(CGPointMake(screenSize.width / 2, screenSize.height + 64)).linear()
        config(keyTime: 3.0/6.0).to(CGPointMake(75, 320)).easeInOut()
        config(keyTime: 4.0/6.0).to(CGPointMake(100, 320)).easeInOut()
        config(keyTime: 5.0/6.0).to(CGPointMake(100 - screenSize.width, 320)).easeInOut()
        }.duration(6)

    let scaleUp = B.scale(to: 1.7).begin(2.0).duration(1.0)
    let scaleDown = B.scale(to: 0.0).begin(3.0).duration(0.8)

    let group = G.combine(move, scaleUp, scaleDown).duration(6)
    return group
}

public func createCircleAnimation(screenSize: CGSize) -> CAAnimation {
    let moveCenter = B
        .move(
            from: CGPointMake(screenSize.width/2 + screenSize.width, screenSize.height/2 - 20),
            by: CGPointMake(-screenSize.width, 0))
        .begin(3)
        .duration(1)

    let moveLeft = B
        .move(by: CGPointMake(-screenSize.width, 0))
        .begin(4)
        .duration(1)

    let group = G.combine(moveCenter, moveLeft).duration(6)
    return group
}


public func createButtonAnimation(screenSize: CGSize) -> CAAnimation {
    let moveCenter = B
        .move(
            from: CGPointMake(screenSize.width/2 + screenSize.width + 100, screenSize.height/2+160),
            to: CGPointMake(screenSize.width/2 - screenSize.width - 100, screenSize.height/2 + 160))
        .duration(2)
        .begin(3)

    let group = G.combine(moveCenter).duration(6)
    return group
}

