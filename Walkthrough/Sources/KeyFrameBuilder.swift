//
//  KeyFrameBuilder.swift
//  Walkthrough
//
//  Created by James Tang on 24/6/15.
//  Copyright © 2015 James Tang. All rights reserved.
//

import QuartzCore

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
