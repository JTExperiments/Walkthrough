//
//  ViewController.swift
//  Walkthrough
//
//  Created by James Tang on 22/6/15.
//  Copyright © 2015 James Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var walkthrough : Walkthrough!
    var appIcon : UIView!
    var appIcon2 : UIView!
    var appIcon3 : UIView!
    var iphone : UIView!
    var circle : UIView!
    var button : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()


        let screenSize = self.view.bounds.size
        let walkthrough = Walkthrough(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))

        self.view.addSubview(walkthrough)

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

        self.walkthrough = walkthrough
        self.appIcon = appIcon
        self.appIcon2 = appIcon2
        self.appIcon3 = appIcon3
        self.iphone = iphone
        self.circle = circle
        self.button = button

        self.reloadAnimation(0)

        walkthrough.scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.New], context: nil)
        self.startBreathing(iphone.layer)
    }

    // MARK: KVO 

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [NSObject : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        let scrollView = self.walkthrough.scrollView
            let time = min(max(0, Float(scrollView.contentOffset.x / scrollView.frame.size.width)), 6)
        self.setTime(NSTimeInterval(time))
    }

    // MARK: Helper

    func reloadAnimation(timeOffset: NSTimeInterval) {
        let screenSize = self.view.bounds.size

        let appIconAnimation = createAppIconAnimation(screenSize)
        let appIcon2Animation = createAppIcon2Animation(screenSize)
        let appIcon3Animation = createAppIcon3Animation(screenSize)
        let iphoneAnimation = createIPhoneAnimation(screenSize)
        let circleAnimation = createCircleAnimation(screenSize)
        let buttonAnimation = createButtonAnimation(screenSize)

        appIconAnimation.speed = 0
        appIcon2Animation.speed = 0
        appIcon3Animation.speed = 0
        iphoneAnimation.speed = 0
        circleAnimation.speed = 0
        buttonAnimation.speed = 0

        appIconAnimation.beginTime = CACurrentMediaTime()
        appIcon2Animation.beginTime = CACurrentMediaTime()
        appIcon3Animation.beginTime = CACurrentMediaTime()
        iphoneAnimation.beginTime = CACurrentMediaTime()
        circleAnimation.beginTime = CACurrentMediaTime()
        buttonAnimation.beginTime = CACurrentMediaTime()

        appIconAnimation.timeOffset = timeOffset
        appIcon2Animation.timeOffset = timeOffset
        appIcon3Animation.timeOffset = timeOffset
        iphoneAnimation.timeOffset = timeOffset
        circleAnimation.timeOffset = timeOffset
        buttonAnimation.timeOffset = timeOffset

        appIcon.layer.addAnimation(appIconAnimation, forKey: "appIcon1Timeline")
        appIcon2.layer.addAnimation(appIcon2Animation, forKey: "appIcon2Timeline")
        appIcon3.layer.addAnimation(appIcon3Animation, forKey: "appIcon3Timeline")
        iphone.layer.addAnimation(iphoneAnimation, forKey: "iphoneTimeline")
        circle.layer.addAnimation(circleAnimation, forKey: "circleAnimation")
        button.layer.addAnimation(buttonAnimation, forKey: "buttonAnimation")
    }

    func startBreathing(layer: CALayer) {
        let breath = CAKeyframeAnimation(keyPath: "transform.scale")
        breath.values = [
            1, 1, 1.05
        ]
        breath.keyTimes = [
            0, 0.2, 1.0
        ]
        breath.duration = 1
        breath.autoreverses = true
        breath.repeatCount = MAXFLOAT
        breath.fillMode = kCAFillModeForwards
        breath.removedOnCompletion = false
        layer.addAnimation(breath, forKey: "breath")
    }

    func setTime(time: NSTimeInterval) {
        self.reloadAnimation(time)
    }
}

