//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let screenSize = CGSizeMake(320, 568)
let walkthrough = Walkthrough(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))

//self.view.addSubview(walkthrough)

let iphone = ShapeView(shape: RoundedRectangle(rect: CGRectMake(0, 0, 180, 360), strokeColor: UIColor.blackColor(), fillColor: UIColor.whiteColor(), cornerRadius: 30))
iphone.layer.position = walkthrough.center

let circle = ShapeView(shape: Oval(rect: CGRectMake(0, 0, 180, 180), strokeColor: UIColor.darkGrayColor(), fillColor: UIColor.whiteColor()))
circle.layer.position = CGPointMake(screenSize.width + 90, screenSize.height / 2 - 20)


let button = ShapeView(shape: Rectangle(rect: CGRectMake(0, 0, 300, 44), strokeColor: UIColor.blackColor(), fillColor: UIColor.lightGrayColor()))
button.layer.position = CGPointMake(screenSize.width + 150, screenSize.height)

let appIcon = ShapeView(shape: RoundedRectangle(rect: CGRectMake(0, 0, 64, 64), strokeColor: UIColor.blackColor(), fillColor: UIColor.grayColor(), cornerRadius: 16))
appIcon.layer.position = CGPointMake(40, 250)
appIcon.layer.opacity = 0

let appIcon2 = ShapeView(shape: RoundedRectangle(rect: CGRectMake(0, 0, 64, 64), strokeColor: UIColor.blackColor(), fillColor: UIColor.lightGrayColor(), cornerRadius: 16))

let appIcon3 = ShapeView(shape: RoundedRectangle(rect: CGRectMake(0, 0, 64, 64), strokeColor: UIColor.blackColor(), fillColor: UIColor.darkGrayColor(), cornerRadius: 16))

walkthrough.addSubview(iphone)
walkthrough.addSubview(appIcon3)
walkthrough.addSubview(appIcon)
walkthrough.addSubview(appIcon2)
walkthrough.addSubview(circle)
walkthrough.addSubview(button)

iphone.userInteractionEnabled = false
appIcon3.userInteractionEnabled = false
appIcon2.userInteractionEnabled = false
appIcon.userInteractionEnabled = false
circle.userInteractionEnabled = false
button.userInteractionEnabled = false

appIcon.layer.addAnimation(createAppIconAnimation(screenSize), forKey: "appIcon1Timeline")
appIcon2.layer.addAnimation(createAppIcon2Animation(screenSize), forKey: "appIcon2Timeline")
appIcon3.layer.addAnimation(createAppIcon3Animation(screenSize), forKey: "appIcon3Timeline")
iphone.layer.addAnimation(createIPhoneAnimation(screenSize), forKey: "iphoneTimeline")
circle.layer.addAnimation(createCircleAnimation(screenSize), forKey: "circleAnimation")
button.layer.addAnimation(createButtonAnimation(screenSize), forKey: "buttonAnimation")

walkthrough.animateScrollView(4.0, delay: 0)
XCPShowView("iphone5", view: walkthrough)
XCPSetExecutionShouldContinueIndefinitely()


