import UIKit

typealias B = CABasicAnimation
typealias S = CASpringAnimation
typealias G = CAAnimationGroup
typealias K = CAKeyframeAnimation

public protocol NSValueable {
    func toAnyObject() -> AnyObject
}

extension Float : NSValueable {
    public func toAnyObject() -> AnyObject {
        return NSNumber(float: self)
    }
}

extension CGPoint : NSValueable {
    public func toAnyObject() -> AnyObject {
        return NSValue(CGPoint: self)
    }
}

extension CAAnimation {

    func begin(beginTime: NSTimeInterval) -> Self {
        self.beginTime = beginTime
        return self
    }

    func duration(duration: NSTimeInterval) -> Self {
        self.duration = duration
        return self
    }

    func fill(fillMode: String) -> Self {
        self.fillMode = fillMode
        return self
    }

}

extension CABasicAnimation {

    static func keyPath(keyPath: String, from: NSValueable? = nil, to: NSValueable? = nil, by: NSValueable? = nil, fillMode: String = kCAFillModeForwards, removedOnCompletion: Bool = false) -> Self {
        let animation = self(keyPath: keyPath)
        animation.fromValue = from?.toAnyObject()
        animation.toValue = to?.toAnyObject()
        animation.byValue = by?.toAnyObject()
        animation.fillMode = fillMode
        animation.removedOnCompletion = removedOnCompletion
        return animation
    }

    static func fade(from from: Float? = nil, to: Float? = nil, by: Float? = nil) -> Self {
        return self.keyPath("opacity", from: from, to: to, by: by)
    }

    static func scale(from from: Float? = nil, to: Float? = nil, by: Float? = nil) -> Self {
        return self.keyPath("transform.scale", from: from, to: to, by: by)
    }

    static func move(from from: CGPoint? = nil, to: CGPoint? = nil, by: CGPoint? = nil) -> Self {
        return self.keyPath("position", from: from, to: to, by: by)
    }

    // MARK: Timing Function

    func linear() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return self
    }

    func easeIn() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        return self
    }

    func easeOut() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        return self
    }

    func easeInOut() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return self
    }

    func defaultTiming() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        return self
    }

    func timing(timingFunction: CAMediaTimingFunction) -> Self {
        self.timingFunction = timingFunction
        return self
    }

}

extension CASpringAnimation {

}

extension CAAnimationGroup {
    static func combine(animations: CAAnimation ...) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        var all = [CAAnimation]()
        for animation in animations {
            all.append(animation)
        }
        group.animations = all
        return group
    }
}


class Frame<T> {
    var keyTime : Float    // 0...1
    var timingFunction : CAMediaTimingFunction?
    var value: T?

    init (keyTime: Float) {
        self.keyTime = keyTime
    }

    func to(value: T) -> Self {
        self.value = value
        return self
    }

    // MARK: Timing Function

    func linear() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return self
    }


    func easeIn() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        return self
    }


    func easeOut() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        return self
    }

    func easeInOut() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return self
    }

    func defaultTiming() -> Self {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        return self
    }

    func timing(timingFunction: CAMediaTimingFunction) -> Self {
        self.timingFunction = timingFunction
        return self
    }

}

class KeyFrameBuilder<T : NSValueable> {

    let animation : CAKeyframeAnimation
    var frames : [Frame<T>] = []

    init(animation: CAKeyframeAnimation) {
        self.animation = animation
    }

    func build(keyTime: Float) -> Frame<T> {
        let frame = Frame<T>(keyTime: keyTime)
        frames.append(frame)
        return frame
    }

    func commit() {
        var keyTimes = [Float]()
        var values = [AnyObject]()
        var functions = [CAMediaTimingFunction]()
        for frame in frames {
            keyTimes.append(frame.keyTime)
            values.append(frame.value!.toAnyObject())
            let function = frame.timingFunction ?? CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            print(function)
            functions.append(function)
        }
        animation.keyTimes = keyTimes
        animation.values = values
        animation.timingFunctions = functions
    }

}

extension CAKeyframeAnimation {

    typealias MoveConfiguration = ((((keyTime:Float)->Frame<CGPoint>)) -> ())

    static func move(configuration: MoveConfiguration) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        let builder = KeyFrameBuilder<CGPoint>(animation: animation)
        configuration(builder.build)
        builder.commit()
        return animation
    }
    
}