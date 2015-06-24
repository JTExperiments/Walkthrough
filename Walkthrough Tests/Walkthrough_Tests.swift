//
//  Walkthrough_Tests.swift
//  Walkthrough Tests
//
//  Created by James Tang on 24/6/15.
//  Copyright © 2015 James Tang. All rights reserved.
//

import XCTest
import Walkthrough

class Walkthrough_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicMove() {

        let animation = B.move { (from, by, to, delay, duration, timing) -> () in
            from(x: 0, y: 1);to(x: 2, y: 4);by(x: 3, y: 5);delay(1).duration(2).timing(.EaseInOut)
        }
        XCTAssertNotNil(animation)
        XCTAssertEqual(animation.fromValue!.CGPointValue, CGPointMake(0, 1))
        XCTAssertEqual(animation.toValue!.CGPointValue, CGPointMake(2, 4))
        XCTAssertEqual(animation.byValue!.CGPointValue, CGPointMake(3, 5))
        XCTAssertEqual(animation.beginTime, 1)
        XCTAssertEqual(animation.duration, 2)
        XCTAssertTrue(animation.timingFunction == CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))

    }


    func testBasicScale() {

        let animation = B.scale { (from, by, to, delay, duration, timing) -> () in
            from(1);by(2);to(3);delay(1);duration(2);timing(.EaseInOut)
        }
        XCTAssertNotNil(animation)
        XCTAssertEqual(animation.fromValue as! Float, 1.0)
        XCTAssertEqual(animation.byValue as! Float, 2.0)
        XCTAssertEqual(animation.toValue as! Float, 3.0)
        XCTAssertEqual(animation.beginTime, 1)
        XCTAssertEqual(animation.duration, 2)
        XCTAssertTrue(animation.timingFunction == CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
    }

}
