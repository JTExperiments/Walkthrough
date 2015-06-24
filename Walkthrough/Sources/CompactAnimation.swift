import QuartzCore

public typealias B = CABasicAnimation
public typealias S = CASpringAnimation
public typealias G = CAAnimationGroup
public typealias K = CAKeyframeAnimation
public typealias PointValueHandler = (x: CGFloat, y: CGFloat)

public protocol NSValueable {
    func toAnyObject() -> AnyObject
}

extension Float : NSValueable {
    public func toAnyObject() -> AnyObject {
        return NSNumber(float: self)
    }
}

extension CGFloat : NSValueable {
    public func toAnyObject() -> AnyObject {
        return NSNumber(float: Float(self))
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

public extension CABasicAnimation {

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

    public static func move(builder: (builder:BasicAnimationBuilder)->()) -> Self {
        let builder = BasicAnimationBuilder()
        let animation = self(keyPath:"position")
        builder.apply(animation)
        return animation
    }

    public static func move(handler:MoveHandler) -> Self {
        let builder = BasicAnimationBuilder()
        handler(from: builder.from, by: builder.by, to: builder.to, delay: builder.delay, duration: builder.duration, timing: builder.timing)
        let animation = self(keyPath:"position")
        builder.apply(animation)
        return animation
    }

    public static func scale(handler:ScaleHandler) -> Self {
        let builder = BasicAnimationBuilder()
        handler(from: builder.from, by: builder.by, to: builder.to, delay: builder.delay, duration: builder.duration, timing: builder.timing)
        let animation = self(keyPath:"transform.scale")
        builder.apply(animation)
        return animation
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


public class Frame<T> {
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

public extension CAKeyframeAnimation {

    public typealias MoveConfiguration = ((((keyTime:Float)->Frame<CGPoint>)) -> ())

    public static func move(configuration: MoveConfiguration) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        let builder = KeyFrameBuilder<CGPoint>(animation: animation)
        configuration(builder.build)
        builder.commit()
        return animation
    }
    
}