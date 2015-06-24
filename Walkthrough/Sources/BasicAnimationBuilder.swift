//
//  BasicAnimationBuilder.swift
//  Walkthrough
//
//  Created by James Tang on 24/6/15.
//  Copyright © 2015 James Tang. All rights reserved.
//

import QuartzCore

public enum Timing {
    case Default
    case Linear
    case EaseIn
    case EaseOut
    case EaseInOut
    case Custom(function: CAMediaTimingFunction)

    func function() -> CAMediaTimingFunction {
        switch (self) {
        case .Default: return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        case .Linear: return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .EaseIn: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .EaseOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .EaseInOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        case let .Custom(function: function): return function
        }
    }
}

public typealias MoveHandler = ((from:PointHandler, by: PointHandler, to: PointHandler, delay:DelayHandler, duration: DurationHandler, timing: TimingHandler) -> ())
public typealias ScaleHandler = ((from:FloatHandler, by: FloatHandler, to: FloatHandler, delay:DelayHandler, duration: DurationHandler, timing: TimingHandler) -> ())
public typealias FloatHandler = ((CGFloat?)->BasicAnimationBuilder)
public typealias PointHandler = ((x:CGFloat, y:CGFloat)->BasicAnimationBuilder)
public typealias DelayHandler = ((NSTimeInterval)->BasicAnimationBuilder)
public typealias DurationHandler = ((NSTimeInterval)->BasicAnimationBuilder)
public typealias TimingHandler = ((Timing)->BasicAnimationBuilder)

public class BasicAnimationBuilder {

    var _from : AnyObject?
    var _by : AnyObject?
    var _to : AnyObject?
    var _delay : NSTimeInterval = 0
    var _duration : NSTimeInterval = 0
    var _timing : Timing?

    public func from(value: AnyObject?) -> Self {
        _from = value
        return self
    }

    public func by(value: AnyObject?) -> Self {
        _by = value
        return self
    }

    public func to(value: AnyObject?) -> Self {
        _to = value
        return self
    }

    public func from(value: CGFloat?) -> Self {
        _from = value?.toAnyObject()
        return self
    }

    public func by(value: CGFloat?) -> Self {
        _by = value?.toAnyObject()
        return self
    }

    public func to(value: CGFloat?) -> Self {
        _to = value?.toAnyObject()
        return self
    }

    public func from(x: CGFloat, y: CGFloat) -> Self {
        _from = CGPointMake(x, y).toAnyObject()
        return self
    }

    public func to(x: CGFloat, y: CGFloat) -> Self {
        _to = CGPointMake(x, y).toAnyObject()
        return self
    }

    public func by(x: CGFloat, y: CGFloat) -> Self {
        _by = CGPointMake(x, y).toAnyObject()
        return self
    }

    public func delay(time: NSTimeInterval) -> Self {
        _delay = time
        return self
    }

    public func duration(time: NSTimeInterval) -> Self {
        _duration = time
        return self
    }

    public func timing(timing: Timing) -> Self {
        _timing = timing
        return self
    }

    func apply(animation: CABasicAnimation) {
        animation.fromValue = _from
        animation.byValue = _by
        animation.toValue = _to
        animation.beginTime = _delay
        animation.duration = _duration
        animation.timingFunction = _timing?.function()
    }
    
}

